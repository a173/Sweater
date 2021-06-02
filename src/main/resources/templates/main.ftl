<#import "parts/common.ftl" as c>

<@c.page>
    <form class="row row-cols-lg-auto g-2 align-items-center" method="get" action="main"
          xmlns="http://www.w3.org/1999/html">
        <div class="col-auto">
            <input type="text" name="filter" class="form-control" value="${RequestParameters.filter!}" placeholder="Search">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>
    <a class="btn btn-primary my-2" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        ADD new Message
    </a>
    <div class="collapse" id="collapseExample">
        <form class="row row-cols-lg-auto g-2 align-items-center" method="post" enctype="multipart/form-data">
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="text" placeholder="Введите сообщение"></textarea>
            <div class="col-3">
                <input class="form-control" type="text" name="tag" placeholder="Тэг" />
            </div>
            <div class="col-3">
                <div class="input-group">
                    <input type="file" name="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
                </div>
            </div>
<#--            <input type="file" name="file">-->
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn btn-primary">ADD</button>
        </form>
    </div>

    <div class="row row-cols-1 row-cols-md-3 g-4">
            <#list messages as message>
                <div class="col">
                    <div class="card">
                        <#if message.filename??><img class="card-img-top" src="/img/${message.filename}"/></#if>
                        <div class="card-body">
                            <span class="card-text">${message.text}</span>
                            <i class="card-text">${message.tag}</i>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted">Автор: ${message.author}</small>
                        </div>
                    </div>
                </div>
            <#else>
                <div class="my-4 mx-1">No messages</div>
            </#list>
    </div>
</@c.page>