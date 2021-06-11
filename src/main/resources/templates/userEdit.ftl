<#import "parts/common.ftl" as c>

<@c.page>
    <div>User editor</div>
    <form action="/user/${user.id}" method="post">
        <div class="form-floating mb-3">
            <input class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       value="${user.username}" id="floatingInput" type="text" name="username" placeholder="username" />
                <label for="floatingInput">Username</label>
                <#if usernameError??><div class="invalid-feedback">${usernameError}</div></#if>
        </div>
        <div class="form-floating mb-3">
            <input class="form-control ${(emailError??)?string('is-invalid', '')}"
                   value="${user.email}" id="floatingInput2" type="email" name="email" placeholder="email" />
            <label for="floatingInput2">Email</label>
            <#if emailError??><div class="invalid-feedback">${emailError}</div></#if>
        </div>
        <#list roles as role>
            <div>
                <input class="form-check-input" type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")} />
                    <label class="form-check-label">${role}</label>
            </div>
        </#list>
        <div class="form-check form-switch">
            <input class="form-check-input" name="active" type="checkbox" id="flexSwitchCheckChecked" ${(user.isEnabled())?string("checked", "")} />
            <label class="form-check-label" for="flexSwitchCheckChecked">Enabled</label>
        </div>
        <input type="hidden" name="userId" value="${user.id}" />
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary mt-3" type="submit">Save</button>
    </form>
</@c.page>
