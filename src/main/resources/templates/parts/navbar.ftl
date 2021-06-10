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
                <#if user??>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="/user-messages/${currentUserId}">My messages</a>
                </li>
                </#if>
                <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="/user">User list</a>
                </li>
                </#if>
            </ul>
            <#if user??>
                <div class="navbar-text"><a href="/user/profile">${name}</a></div>&nbsp;
                <@l.logout />
            <#else>
                <a class="btn btn-primary btn-sm" href="/registration" role="button">Sign up</a>&nbsp;
                <a class="btn btn-primary btn-sm" href="/login" role="button">Sign in</a>
            </#if>
        </div>
    </div>
</nav>