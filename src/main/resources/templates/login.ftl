<#--<#include "parts/security.ftl">-->
<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>
    <#if Session.SPRING_SECURITY_CONTEXT??>
        <div class="alert alert-danger" role="alert">
            User is already logged in
        </div>
    <#else>
        <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
            <div class="alert alert-danger" role="alert">
                ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
            </div>
        </#if>
        <@l.login "/login" false/>
    </#if>
</@c.page>
