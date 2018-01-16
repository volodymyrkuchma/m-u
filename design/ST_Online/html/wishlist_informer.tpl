{* Информер избранного (отдаётся аяксом) *}
<a class="{if $wished_products|count > 0}color{else}disabled{/if}" href="{$lang_link}wishlist">
	<svg class="isvg" width="20" height="18">{include file='svg.tpl' item='isvg-wishlist'}</svg>
	<span class="informer_name hidden-sm-down" data-language="wishlist_header">{$lang->wishlist_header}</span>
	<span class="informer_counter">({$wished_products|count})</span>
</a>
