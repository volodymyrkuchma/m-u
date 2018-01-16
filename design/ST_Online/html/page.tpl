{* Page template *}

{* The canonical address of the page *}
{$canonical="/{$page->url}" scope=parent}

{if $page->url == '404'}
    {include file='page_404.tpl'}

{else}
    {* The page heading *}
    <h1 class="page_header" data-page="{$page->id}">
        {$page->name|escape}
    </h1>

    {* The page content *}
    {if $page->description}
		<article class="block p-1">
			{$page->description}
		</article>

	{else}
		<div style='margin:5vh 0 10vh'>
			<i><b>Страница на стадии оформления</b><br />
			Попробуйте зайти позже</i>
		</div>
	{/if}

{/if}

<hr>