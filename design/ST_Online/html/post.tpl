{* Post page *}

{* The canonical address of the page *}
{if $smarty.get.type_post == "blog"}
    {$canonical="/blog/{$post->url}" scope=parent}
{else}
    {$canonical="/news/{$post->url}" scope=parent}
{/if}


{* Заголовок страницы *}
<h1 class="page_header" data-post="{$post->id}">{$post->name|escape}</h1>

<article class="px-sm p-1 col-lg-10 col-xl-9">
	{* Post date *}
	<div class="text-sm mb-1">
	{$post->date|date}
	</div>

	{* Post content *}
	{$post->description}
</article>


{* Social share *}
<div class="my-2 p-1 b bg-light z_day">
	<p class="text-bold text-md">Понравилось? Поделитесь с друзьями!</p>
	<div class="ya-share2" data-services="vkontakte,facebook,twitter,viber"></div>
</div>


{* Previous/Next posts *}
{if $prev_post || $next_post}
<nav class="pager clearfix">
	{if $prev_post}
		<a class="link-prev" href="{$lang_link}{$post->type_post}/{$prev_post->url}">
			<svg class="isvg" width="26" height="26">{include file='svg.tpl' item='pager'}</svg>
			<span>{$prev_post->name|escape|truncate:80:'...'}</span>
		</a>
	{/if}

	{if $next_post}
		<a class="link-next" href="{$lang_link}{$post->type_post}/{$next_post->url}">
			<span>{$next_post->name|escape|truncate:80:'...'}</span>
			<svg class="isvg" width="26" height="26">{include file='svg.tpl' item='pager'}</svg>
		</a>
	{/if}
</nav>
{/if}



<div id="comments">
	<div class="page_header mt-2" data-language="post_comments">
	{$lang->post_comments}
	</div>

	<div class="row">
		<div class="col-lg-7 mb-1">
			{if $comments}
				{function name=comments_tree level=0}
					{foreach $comments as $comment}

						{* Comment anchor *}
						<a name="comment_{$comment->id}"></a>

						{* Comment list *}
						<div class="comment_item{if $level > 0} admin_note{/if}">

							<div class="comment_header">
								{* Comment name *}
								<span class="comment_author">{$comment->name|escape}</span>

								{* Comment date *}
								<span class="comment_date">{$comment->date|date}, {$comment->date|time}</span>

								{* Comment status *}
								{if !$comment->approved}
									<span data-language="post_comment_status">({$lang->post_comment_status})</span>
								{/if}
							</div>

							{* Comment content *}
							<div class="comment_content">
								{$comment->text|escape|nl2br}
							</div>

							 {if isset($children[$comment->id])}
								{comments_tree comments=$children[$comment->id] level=$level+1}
							{/if}
						</div>

					{/foreach}
				{/function}
				{comments_tree comments=$comments}
			{else}
				<div class="no_comments my-1" data-language="post_no_comments">
					{*$lang->post_no_comments*}
					Удивительно, но никто не оставил ни одного отзыва.<br />
					Вы можете стать первым!
				</div>
			{/if}
		</div>
		<div class="col-lg-5">
		   <form class="fn_validate_post form bg-white" id="fn-blog_comment"  method="post" action="">

				<div class="h3 text-light text-caps mb-1" data-language="post_write_comment">
				{$lang->post_write_comment}
				</div>

				{* Form error messages *}
				{if $error}
					<div class="message_error">
						{if $error=='captcha'}
							<span data-language="form_error_captcha">{$lang->form_error_captcha}</span>
						{elseif $error=='empty_name'}
							<span data-language="form_enter_name">{$lang->form_enter_name}</span>
						{elseif $error=='empty_comment'}
							<span data-language="form_enter_comment">{$lang->form_enter_comment}</span>
						{elseif $error=='empty_email'}
							<span data-language="form_enter_email">{$lang->form_enter_email}</span>
						{/if}
					</div>
				{/if}

				<div class="row">
					{* User's name *}
					<div class="col-md-6 col-lg-12 col-xl-6 form_group">
						<input class="form_input" type="text" name="name" value="{$comment_name|escape}" placeholder="{$lang->form_name}" required >
					</div>

					{* User's email *}
					<div class="col-md-6 col-lg-12 col-xl-6 form_group">
						<input class="form_input" type="text" name="email" value="{$comment_email|escape}" placeholder="{$lang->form_email}"/>
					</div>
				</div>

				{* User's comment *}
				<div class="form_group">
					<textarea class="form_textarea" rows="5" name="text" placeholder="{$lang->form_enter_comment}" required >{$comment_text}</textarea>
				</div>

				{* Captcha *}
				{if $settings->captcha_post}
					{get_captcha var="captcha_post"}
					<div class="captcha">
						<input class="form_input input_captcha" type="text" name="captcha_code" value="" placeholder="{*$lang->form_enter_captcha*}Код*">
						<div class="secret_number">{$captcha_post[0]|escape} + ? =  {$captcha_post[1]|escape}</div>
					</div>
				{/if}

				{* Submit button *}
				<input class="button" type="submit" name="comment" data-language="form_send" value="{$lang->form_send}">
		   </form>
	   </div>
   </div>
</div>


{* Related products *}
{if $related_products}
    <div class="page_header mt-3" data-language="product_recommended_products">
        {*$lang->product_recommended_products*}
		<span>Связанные </span>&nbsp;предложения
    </div>

    <div class="row {$smarty.get.module} products-grid slick-products mx-0">
        {foreach $related_products as $p}
            <div class="col-sm-6 col-md-4 col-lg-3 col-xl-20 products-item">
                {include "product_list.tpl" product = $p}
            </div>
        {/foreach}
    </div>
{/if}