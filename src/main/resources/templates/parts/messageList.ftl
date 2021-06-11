<#include "security.ftl">
<#import "pager.ftl" as p>

<@p.pager url page />
<div class="row row-cols-1 row-cols-md-3 g-4 my-2" id="message-list">
    <#list page.content as message>
        <div class="col" data-id="${message.id}">
            <div class="card">
                <#if message.filename??><img class="card-img-top" src="/img/${message.filename}" /></#if>
                <div class="card-body">
                    <span class="card-text">${message.text}</span><br />
                    <#if message.tag != ""><a href="/main?filter=${message.tag}"><i class="card-text">#${message.tag}</i></a></#if>
                </div>
                <div class="card-footer text-muted d-flex justify-content-between">
                    <small class="align-self-center">Author: <#if message.author??><a href="/user-messages/${message.author.id}">${message.authorName}</a></#if></small>
                    <div>
                        <a href="/${message.id}/like" role="button" class="btn btn-outline-danger">
                            <#if message.meLiked>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />
                                </svg>
                            <#else>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                    <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z" />
                                </svg>
                            </#if>
                            ${message.likes}
                        </a>
                        <#if message.author?? && message.author.id == currentUserId>
                            <a class="btn btn-primary" role="button" href="/user-messages/${message.author.id}?message=${message.id}">Edit</a>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    <#else>
        <div class="my-4 mx-1">No messages</div>
    </#list>
</div>
<@p.pager url page />
