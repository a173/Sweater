<#assign know = Session.SPRING_SECURITY_CONTEXT??>

<#if know>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        name = user.getUsername()
        isAdmin = user.isAdmin()
        currentUserId = user.getId()
        isActive = user.getActivationCode()?has_content
    >
<#else>
    <#assign
        name = "unknown"
        isAdmin = false
        currentUserId = -1
        isActive = false
    >
</#if>
