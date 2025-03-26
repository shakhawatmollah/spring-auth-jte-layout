@import com.shakhawat.springauthjtelayout.dto.LoginRequest
@param LoginRequest loginRequest
@param String error

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h3 class="text-center">Login</h3>
                </div>
                <div class="card-body">
                    @if(error != null)
                        <div class="alert alert-danger">${error}</div>
                    @endif

                    <form action="/auth/authenticate" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control"
                                   id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control"
                                   id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form>
                    <div class="mt-3 text-center">
                        <a href="/auth/register">Don't have an account? Register</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>