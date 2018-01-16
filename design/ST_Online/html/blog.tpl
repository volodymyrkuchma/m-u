{* The blog page template *}

{* The canonical address of the page *}
{if $smarty.get.type_post == "blog"}
    {$canonical="/blog" scope=parent}
    {else}
    {$canonical="/news" scope=parent}
{/if}

{* Заголовок страницы *}
<h1 class="h1 page_header" data-page="{$page->id}">{$page->name}</h1>

{* The list of the blog posts *}
<div class="row {$smarty.get.module} post_list">
	{foreach $posts as $post}
	<div class="col-sm-6 col-lg-4 col-xl-3{if $post@first} first{/if} post_item anim-all">

			{* Изображение *}
			<a class="post_image" href="{$lang_link}{$smarty.get.type_post}/{$post->url}">
				{if $post->image}	<img src="{$post->image|resize:300:300:false:$config->resized_blog_dir}" alt="{$post->name|escape}" title="{$post->name|escape}">
				{else}				<svg class="fn_img isvg" width="44" height="44">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
			</a>

			{* Дата создания *}
			<div class="post_date">{$post->date|date}</div>

			<div class="post_content">
				{* Название *}
				<h4 class="title">
					<a href="{$lang_link}{$smarty.get.type_post}/{$post->url}" data-post="{$post->id}">{$post->name|truncate:70:'...'}</a>
				</h4>

				{* Краткое описание *}
				{if $post->annotation}
					<div class="post_annotation">
						{$post->annotation|strip_tags|truncate:150:'...'}
					</div>
				{/if}
			</div>

	</div>
	{/foreach}
</div>



{* Pagination *}
{if $total_pages_num > 1}
<div class="row mx-0 products-toolbar">
	<div class="col-12">{include file='pagination.tpl'}</div>
</div>
{/if}