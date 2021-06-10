<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <#if Session.SPRING_SECURITY_CONTEXT??>
        <div class="alert alert-danger" role="alert">
            User is already logged in
        </div>
    <#else>
        <div class="mb-1">ADD new user</div>
        <@l.login "/registration" true/>
    </#if>
</@c.page>