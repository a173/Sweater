<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
    <form class="row row-cols-lg-auto g-2 align-items-center" method="get" action="main"
          xmlns="http://www.w3.org/1999/html">
        <div class="col-auto">
            <input type="text" name="filter" class="form-control" value="${RequestParameters.filter!}" placeholder="Search by tag">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>

    <#if user??>
        <#include "parts/messageEdit.ftl" />
    </#if>
    <#include "parts/messageList.ftl" />

</@c.page>