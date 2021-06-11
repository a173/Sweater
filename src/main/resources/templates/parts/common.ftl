<#include "security.ftl">

<#macro page>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Sweater</title>
    <link rel="stylesheet" href="/static/style.css" />

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Optional JavaScript; choose one of the two! -->
    <script src="https://www.google.com/recaptcha/api.js" async="async defer" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/turbolinks/5.2.0/turbolinks.js" async="async defer" ></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous" />
</head>
<body>
<#include "navbar.ftl">
<div class="container mt-5">
    <#if user?? && isActive>
        <div class="alert alert-danger" role="alert">
            Please confirm email
        </div>
    </#if>
    <#nested>
</div>
<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous" async="async defer" ></script>
</body>
</html>
</#macro>
