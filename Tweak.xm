#include <substrate.h>
#include <dlfcn.h>

static id (*original_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode)(id inputMode);
id replace_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode(id inputMode){
	NSLog(@"inputMode %@",inputMode);
	if ([inputMode isEqualToString:@"zh_Hans-Pinyin"])
	{
		return [NSArray arrayWithObjects:@"Pinyin10-Simplified",
										 @"Pinyin-Simplified",
										 @"AZERTY-Pinyin-Simplified",nil];
	}
	if ([inputMode isEqualToString:@"zh_Hant-Pinyin"])
	{
		return [NSArray arrayWithObjects:@"Pinyin10-Traditional",
										 @"Pinyin-Traditional",
										 @"AZERTY-Pinyin-Traditional",nil];
	}
	return original_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode(inputMode);;
}

%ctor{
	MSHookFunction(dlsym(RTLD_DEFAULT,"UIKeyboardGetSupportedSoftwareKeyboardsForInputMode"), (void *)replace_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode, (void **)&original_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode);
}