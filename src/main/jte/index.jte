@import com.shakhawat.springauthjtelayout.model.User
@param String message

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 text-center">
            <h1>Welcome to Spring Security with JWT</h1>
            <div class="mt-4">
                <a href="/auth/register" class="btn btn-primary me-2">Register</a>
                <a href="/auth/login" class="btn btn-success">Login</a>
            </div>
            @if(message != null)
                <div class="alert alert-info mt-3">${message}</div>
            @endif
        </div>
    </div>
</div>
</body>
</html>