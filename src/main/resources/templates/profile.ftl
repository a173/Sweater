<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <h5>${username}</h5>
    ${message!}
    <form method="post">
        <div class="form-floating mb-3">
            <input class="form-control ${(emailError??)?string('is-invalid', '')}"
                   id="floatingInput" type="email" name="email" placeholder="some@some.com" value="${email!''}" />
            <label for="floatingInput">Email</label>
            <#if emailError??><div class="invalid-feedback">${emailError}</div></#if>
        </div>
        <div class="form-floating mb-3">
            <input class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   id="floatingPassword" type="password" name="password" placeholder="password" />
            <label for="floatingPassword">Password</label>
            <#if passwordError??><div class="invalid-feedback">${passwordError}</div></#if>
        </div>

        <div class="form-floating mb-3">
            <input class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   id="floatingPassword2" type="password" name="password2" placeholder="Retype password" />
            <label for="floatingPassword2">Confirm password</label>
            <#if passwordError??><div class="invalid-feedback">${passwordError}</div></#if>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary mt-3" type="submit">Update</button>
    </form>
</@c.page>
