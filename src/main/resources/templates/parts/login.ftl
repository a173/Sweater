<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-floating mb-3">
        <input class="form-control ${(usernameError??)?string('is-invalid', '')}"
               value="<#if user??>${user.username}</#if>" id="floatingInput" type="text" name="username" placeholder="username" />
        <label for="floatingInput">Username</label>
        <#if isRegisterForm && usernameError??><div class="invalid-feedback">${usernameError}</div></#if>
    </div>
    <#if isRegisterForm>
        <div class="form-floating mb-3">
            <input class="form-control ${(emailError??)?string('is-invalid', '')}"
                   value="<#if user??>${user.email}</#if>" id="floatingInput2" type="email" name="email" placeholder="email" />
            <label for="floatingInput2">Email</label>
            <#if isRegisterForm && emailError??><div class="invalid-feedback">${emailError}</div></#if>
        </div>
    </#if>
    <div class="form-floating mb-3">
        <input class="form-control ${(passwordError??)?string('is-invalid', '')}"
               id="floatingPassword" type="password" name="password" placeholder="password" />
        <label for="floatingPassword">Password</label>
        <#if isRegisterForm && passwordError??><div class="invalid-feedback">${passwordError}</div></#if>
    </div>
    <#if isRegisterForm>
        <div class="form-floating mb-3">
            <input class="form-control ${(password2Error??)?string('is-invalid', '')}"
                   id="floatingPassword2" type="password" name="password2" placeholder="Retype password" />
            <label for="floatingPassword2">Password</label>
            <#if isRegisterForm && password2Error??><div class="invalid-feedback">${password2Error}</div></#if>
        </div>
        <div class="form-floating mb-3">
            <div class="g-recaptcha ${(captchaError??)?string('is-invalid', '')}" data-sitekey="6Ld3Nw0bAAAAADPEmkmFTmJSkWeBMh4NZ1c-lbl8"></div>
            <#if captchaError??><div class="invalid-feedback">${captchaError}</div></#if>
        </div>
    </#if>
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
