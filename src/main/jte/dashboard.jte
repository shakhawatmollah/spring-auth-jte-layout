@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Function to get JWT token from cookie
        function getJwtToken() {
            const value = '; ' + document.cookie;
            const parts = value.split('; JWT-TOKEN=');
            if (parts.length === 2) return parts.pop().split(';').shift();
            return null;
        }

        // Set up Axios or Fetch interceptors
        if (typeof axios !== 'undefined') {
            axios.interceptors.request.use(function(config) {
                const token = getJwtToken();
                if (token) {
                    config.headers.Authorization = 'Bearer ' + token;
                }
                return config;
            });
        }

        function performLogout() {
            // Clear client-side token storage
            document.cookie = 'JWT-TOKEN=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            localStorage.removeItem('jwtToken');
            sessionStorage.removeItem('jwtToken');

            // Call server logout
            fetch('/auth/logout', {
                method: 'POST',
                credentials: 'same-origin'
            })
                .then(() => window.location.href = '/auth/login?logout')
                .catch(error => console.error('Logout failed:', error));
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">JWT Auth</a>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text me-3">Welcome, ${username}!</span>
<%--            <a class="nav-link" href="/logout">Logout</a>--%>
            <a class="nav-link" href="#" onclick="performLogout(); return false;">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3>Dashboard</h3>
                </div>
                <div class="card-body">
                    <p>You have successfully logged in and your JWT token is stored.</p>
                    <p>This is a protected page that requires authentication.</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>