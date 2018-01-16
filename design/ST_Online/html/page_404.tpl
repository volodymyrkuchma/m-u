{* The template of page 404 *}

{* The page heading *}
<h1 class="page_header" data-page="{$page->id}">
{$page->name|escape}
</h1>

{* The page content *}
<div class="m-y-1">
    {$page->description}
</div>