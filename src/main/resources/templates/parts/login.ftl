<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-floating mb-3">
        <input class="form-control" id="floatingInput" type="text" name="username" placeholder="username"/>
        <label for="floatingInput">Username</label>
    </div>
    <#if isRegisterForm>
        <div class="form-floating mb-3">
            <input class="form-control" id="floatingInput2" type="email" name="email" placeholder="email"/>
            <label for="floatingInput2">Email</label>
        </div>
    </#if>
    <div class="form-floating mb-3">
        <input class="form-control" id="floatingPassword" type="password" name="password" placeholder="password"/>
        <label for="floatingPassword">Password</label>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button class="btn btn-primary mt-3" type="submit">
        <#if isRegisterForm>
            Create
        <#else>
            Sign In
        </#if>
    </button>
    <#if !isRegisterForm>
        <a class="btn btn-primary mt-3" href="/registration" role="button">Add new user</a>
    </#if>
</form>
</#macro>

<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btn-primary btn-sm">Sign out</button>
</form>
</#macro>