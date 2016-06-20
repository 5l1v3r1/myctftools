<?php

$enable = True;

function M_safe_check($value)
{
	if(is_array($value))
	{
		foreach($value as $key => $val)
		{
			M_safe_check($key);
			M_safe_check($val);
		}
	}
	else
	{
		if(preg_match("/_SESSION/i",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/_SERVER/i",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/select.*from/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/into.*file/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/insert.*into/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/update.*set/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/drop.+/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		//xss
		if(preg_match("/<.*script.*>/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/'.*on.+=/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/\".*on.+=/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
		if(preg_match("/<.*on.+=/is",$value))
		{
			exit('<h1>get out of here</h1>');
		}
	}

}
function M(){
	foreach($_GET as $getkey => $getvalue)
	{
		M_safe_check($getkey);
		M_safe_check($getvalue);
	}
	foreach($_POST as $getkey => $getvalue)
	{
		M_safe_check($getkey);
		M_safe_check($getvalue);
	}
	foreach($_SERVER as $getkey => $getvalue)
	{
		M_safe_check($getkey);
		M_safe_check($getvalue);
	}
	foreach ($_FILES as $fi) 
	{
		if(preg_match("/.+\.php/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		if(preg_match("/.+\.asp/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		if(preg_match("/.+\.cer/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		if(preg_match("/.+\.htr/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		if(preg_match("/.+\.cdx/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		if(preg_match("/htaccess/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		if(preg_match("/\.user\.ini/is",$fi['name']))
			{
				exit('<h1>get out of here</h1>');
			}
		$content=file_get_contents($fi['tmp_name']);
		if(preg_match('/<?/i',$fi['name']))
			{
				exit('<h1>what the fuck do you upload?</h1>');
			}
		if(preg_match('/<script language/i',$fi['name']))
			{
				exit('<h1>what the fuck do you upload?</h1>');
			}
		if(preg_match('/<%/i',$fi['name']))
			{
				exit('<h1>what the fuck do you upload?</h1>');
			}
		if(preg_match('/auto.+file/is',$fi['name']))
			{
				exit('<h1>what the fuck do you upload?</h1>');
			}
		if(preg_match('/php_value/is',$fi['name']))
			{
				exit('<h1>what the fuck do you upload?</h1>');
			}
		if(preg_match('/\$/is',$fi['name']))
			{
				exit('<h1>what the fuck do you upload?</h1>');
			}
	}	
}
if($enable){
	M();
}
?>