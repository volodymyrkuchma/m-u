{* Feedback page *}
{* The canonical address of the page *}
{$canonical="/{$page->url}" scope=parent}

{* The page heading *}
<h1 class="page_header">{$page->name|escape}</h1>

<div class="row">
	{if $page->description}
		<article class="col-lg-6 col-xl-7 mb-2 p-1">
			{$page->description}
		</article>
	{/if}

   <div class="col-lg-6 col-xl-5 mb-2">
	{if $message_sent}
		<div class="message_success">
			<b>{$name|escape},</b> <span data-language="feedback_message_sent">{$lang->feedback_message_sent}.</span>
		</div>

	{else}
	{* Feedback form *}
	<form class="fn_validate_feedback form" method="post">

		{* Form heading *}
		<div class="h3 text-light text-caps mb-1" data-language="feedback_feedback">{$lang->feedback_feedback}</div>

		{* User's name *}
		<div class="form_group">
			<input class="form_input" value="{if $user->name}{$user->name}{else}{$name|escape}{/if}" name="name" type="text" data-language="form_name" placeholder="{$lang->form_name}*" required />
		</div>

		{* User's email *}
		<div class="form_group">
			<input class="form_input" value="{if $user->email}{$user->email}{else}{$email|escape}{/if}" name="email" type="text" data-language="form_email" placeholder="{$lang->form_email}" required />
		</div>

		{* User's message *}
		<div class="form_group">
			<textarea class="form_textarea" rows="5" name="message" data-language="form_enter_message" placeholder="{$lang->form_enter_message}*" required >{$message|escape}</textarea>
		</div>

		{* Form error messages *}
		{if $error}
			<div class="message_error">
				{if $error=='captcha'}
					<span data-language="form_error_captcha">{$lang->form_error_captcha}</span>
				{elseif $error=='empty_name'}
					<span data-language="form_enter_name">{$lang->form_enter_name}</span>
				{elseif $error=='empty_email'}
					<span data-language="form_enter_email">{$lang->form_enter_email}</span>
				{elseif $error=='empty_text'}
					<span data-language="form_enter_message">{$lang->form_enter_message}</span>
				{/if}
			</div>
		{/if}

		{* Captcha *}
		{if $settings->captcha_feedback}
			{get_captcha var="captcha_feedback"}
			<div class="captcha">
				<input class="form_input input_captcha" type="text" name="captcha_code" value="" data-language="form_enter_captcha" placeholder="код" required />
				<div class="secret_number">{$captcha_feedback[0]|escape} + ? =  {$captcha_feedback[1]|escape}</div>
			</div>
		{/if}

		{* Submit button *}
		<input class="button" type="submit" name="feedback" data-language="form_send" value="{$lang->form_send}"/>
	</form>
	{/if}
	</div>
</div>
