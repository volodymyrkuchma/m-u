{* Pagination *}
{if $total_pages_num > 1}
	<div class="pagination{if $ajax} fn_is_ajax{/if}">
		{* Number of visible pagination links *}
		{$visible_pages = 5}

		{* The start and end pagination links *}
		{$page_from = 1}
		{if $current_page_num > floor($visible_pages/2)}
			{$page_from = max(1, $current_page_num-floor($visible_pages/2)-1)}
		{/if}
		{if $current_page_num > $total_pages_num-ceil($visible_pages/2)}
			{$page_from = max(1, $total_pages_num-$visible_pages-1)}
		{/if}
		{$page_to = min($page_from+$visible_pages, $total_pages_num-1)}

		{* Link to the previous page *}
		{if $current_page_num > 1}
			<a class="hidden-lg-down" href="{if $current_page_num == 2}{furl page=null}{else}{furl page=$current_page_num - 1}{/if}#fn_content">{$lang->pagination_prev}</a>
		{/if}

		{* Link to the first page *}
		{if $current_page_num == 1}
			<a class="active disabled">1</a>
		{else}
			<a href="{furl page=null}#fn_content">1</a>
		{/if}

		{* Pagination links *}
		{section name=pages loop=$page_to start=$page_from}
			{$p = $smarty.section.pages.index+1}
			{if ($p == $page_from+1 && $p!=2) || ($p == $page_to && $p != $total_pages_num-1)}
				<a href="{furl page=$p}#fn_content">...</a>
			{elseif $p == $current_page_num}
				<a{if $p==$current_page_num} class="active disabled"{/if}>{$p}</a>
			{else}
				<a href="{furl page=$p}#fn_content">{$p}</a>{/if}
		{/section}

		{* Link to the last page *}
		{if $current_page_num == $total_pages_num}
			<a class="active disabled">{$total_pages_num}</a>
		{else}
			<a href="{furl page=$total_pages_num}#fn_content">{$total_pages_num}</a>
		{/if}

		{* Display all pages *}
		<a href="{furl page=all}#fn_content" data-language="pagination_all">{$lang->pagination_all}</a>

		{* Link to the next page *}
		{if $current_page_num < $total_pages_num}
		<a class="hidden-lg-down" href="{furl page=$current_page_num+1}#fn_content">{$lang->pagination_next}</a>
		{/if}
	</div>
{/if}