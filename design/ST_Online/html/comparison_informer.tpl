{* Compaison informer (given by Ajax) *}
<a class="{if $comparison->products||count > 0}color{else}disabled{/if}" href="{$lang_link}comparison">
	<svg class="isvg-compare" width="20" height="18" viewBox="0 0 29 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">{include file='svg.tpl' item='isvg-compare'}</svg>
	<span class="informer_name hidden-sm-down" data-language="index_comparison">{$lang->index_comparison}</span>
	<span class="informer_counter">({$comparison->products|count})</span>
</a>
