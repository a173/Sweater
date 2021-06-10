<a class="btn btn-primary mt-2" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Message editor
</a>
<div class="collapse <#if message??>show</#if>" id="collapseExample">
    <form class="row row-cols-lg-auto g-2 align-items-center mt-2" method="post" enctype="multipart/form-data">
        <input type="text" class="form-control ${(textError??)?string('is-invalid', '')} mx-1"
               value="<#if message??>${message.text}</#if>" name="text" placeholder="Введите сообщение" />
        <#if textError??><div class="invalid-feedback">${textError}</div></#if>
        <div class="col-3">
            <input class="form-control ${(tagError??)?string('is-invalid', '')}"
                   value="<#if message??>${message.tag}</#if>" type="text" name="tag" placeholder="Тэг" />
            <#if tagError??><div class="invalid-feedback">${tagError}</div></#if>
        </div>
        <div class="col-3">
            <div class="input-group">
                <input type="file" name="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
<#--        <input type="hidden" name="id" value="<#if message??>${message.id}</#if>" />-->
        <button type="submit" class="btn btn-primary">Save Messages</button>
    </form>
</div>