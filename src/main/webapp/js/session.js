/* Local storage is a display cache; the server session authorizes requests. */
(function () {
    const base = new URL("../api/", document.currentScript.src).href;
    const nativeFetch = window.fetch.bind(window);
    window.fetch = async function(input, options) {
        const req = new Request(input instanceof Request ? input : new URL(input, location.href), options);
        const url = new URL(req.url);
        if (url.origin === location.origin && url.href.startsWith(base) && !["GET","HEAD","OPTIONS"].includes(req.method)) {
            const r = await nativeFetch(base + "auth/csrf", {credentials:"same-origin",cache:"no-store"});
            if (!r.ok) throw new Error("Unable to obtain request token");
            const csrf = await r.json();
            const headers = new Headers(req.headers);
            headers.set(csrf.headerName, csrf.token);
            return nativeFetch(new Request(req, {headers,credentials:"same-origin"}));
        }
        return nativeFetch(req);
    };
    window.endSession = async function() {
        const r=await window.fetch(base + "auth/logout",{method:"POST"});
        if(!r.ok && r.status!==401) throw new Error("Logout failed");
        localStorage.removeItem("customer"); localStorage.removeItem("admin");
        sessionStorage.removeItem("pendingPayment");
    };
})();
