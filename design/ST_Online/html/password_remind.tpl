{* Password remind page *}

{* The canonical address of the page *}
{$canonical="/user/password_remind" scope=parent}

{* The page title *}
{$meta_title = $lang->password_remind_title scope=parent}


{* The page heading *}
<h1 class="page_header">
	{$lang->password_remind_header}
</h1>

<div class="row">
	{if $email_sent}
		<div class="col-12">
			{$lang->password_remind_on} <b>{$email|escape}</b> {$lang->password_remind_letter_sent}.
		</div>
	{else}
		<div class="col-sm-8 col-lg-5">
			<form class="form" method="post">
				<div class="form_group">
					{* User's e-mail *}
					<label>
						<div class="mb-1 text-md" data-language="password_remind_enter_your_email">{$lang->password_remind_enter_your_email}</div>
						<input class="form_input" type="text" name="email" value="{$email|escape}" data-language="form_email" placeholder="{$lang->form_email}*"  required />
					</label>
				</div>

				{* Submit button *}
				<input type="submit" class="btn btn-light" data-language="password_remind_remember" value="{$lang->password_remind_remember}">

				{* Form error messages *}
				{if $error}
					<div class="message_error">
						{if $error == 'user_not_found'}<span data-language="password_remind_user_not_found">{$lang->password_remind_user_not_found}</span>
						{else}{$error|escape}{/if}
					</div>
				{/if}
			</form>
		</div>
	{/if}
</div>