<#include "security.ftl">
<#import "login.ftl" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">Sweater</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
<#--                <li class="nav-item">-->
<#--&lt;#&ndash;                    <a class="nav-link active" aria-current="page" href="#">Home</a>&ndash;&gt;-->
<#--                    <a class="nav-link" aria-current="page" href="/">Home</a>-->
<#--                </li>-->
                <li class="nav-item">
                    <#--                    <a class="nav-link active" aria-current="page" href="#">Home</a>-->
                    <a class="nav-link" aria-current="page" href="/main">Messages</a>
                </li>
                <#if isAdmin>
                <li class="nav-item">
                    <#--                    <a class="nav-link active" aria-current="page" href="#">Home</a>-->
                    <a class="nav-link" aria-current="page" href="/user">User list</a>
                </li>
                </#if>
            </ul>
            <#if name!="unknown">
                <div class="navbar-text">${name}</div>&nbsp;
                <@l.logout />
            <#else>
                <a class="btn btn-primary btn-sm" href="/registration" role="button">Sign up</a>&nbsp;
                <a class="btn btn-primary btn-sm" href="/login" role="button">Sign in</a>
            </#if>
        </div>
    </div>
</nav>