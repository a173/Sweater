<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>

<@c.page>
List of Users
    <@p.pager url page />
    <table class="table">
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Role</th>
        <th>Confirm</th>
        <th>Enabled</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <#list page.content as user>
    <tr>
        <th scope="row">${user.id}</th>
        <td>${user.username!"null or missing"}</td>
        <td><#list user.roles as role>${role}<#sep>, </#list></td>
        <td>${user.activationCode?has_content?then("NO", "YES")}</td>
        <td>${user.isEnabled()?then("YES", "NO")}</td>
        <td><a href="/user/${user.id}">edit</a></td>
    </tr>
    </#list>
    </tbody>
    </table>
    <@p.pager url page />
</@c.page>
