{if $products|count > 0}
<div class="sort{if $ajax} fn_is_ajax{/if} clearfix">
	{if $device == mobile}
		<a class="search_link p-0" href="#search">
		<svg class="isvg" width="16" height="16">{include file='svg.tpl' item='isvg-search'}</svg>
		</a>
	{/if}

	<span class="sort_title hidden-lg-down" data-language="products_sort_by">{$lang->products_sort_by}:</span>

	<a class="sort_link{if $sort=='position'} active_up{/if} no_after" href="{furl sort=position page=null}#fn_content" data-language="products_by_default">
	{$lang->products_by_default}
	</a>

	<a class="sort_link{if $sort=='price'} active_up{elseif $sort=='price_desc'} active_down{/if}" href="{if $sort=='price'}{furl sort=price_desc page=null}{else}{furl sort=price page=null}{/if}#fn_content" data-language="products_by_price">
	{$lang->products_by_price}
	</a>

	<a class="sort_link{if $sort=='name'} active_up{elseif $sort=='name_desc'} active_down{/if}" href="{if $sort=='name'}{furl sort=name_desc page=null}{else}{furl sort=name page=null}{/if}#fn_content" data-language="products_by_name">
	{$lang->products_by_name}
	</a>

	<a class="sort_link {if $sort=='rating'} active_up{elseif $sort=='rating_desc'} active_down{/if} hidden-sm-down" {if $sort=='rating'}href="{furl sort=rating_desc page=null}#fn_content" {else}href="{furl sort=rating page=null}{/if}#fn_content" data-language="products_by_rating" data-language="products_by_name">
	{$lang->products_by_rating}
	</a>

</div>
{/if}
