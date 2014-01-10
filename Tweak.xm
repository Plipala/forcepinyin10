#include <substrate.h>
#include <dlfcn.h>

static id (*original_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode)(id inputMode);
id replace_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode(id inputMode){
	if ([inputMode isEqualToString:@"zh_Hans-Pinyin"])
	{
		return [NSArray arrayWithObjects:@"Pinyin10-Simplified",
										 @"Pinyin-Simplified",
										 @"AZERTY-Pinyin-Simplified",nil];
	}
	return original_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode(inputMode);
}

%ctor{
	MSHookFunction(dlsym(RTLD_DEFAULT,"UIKeyboardGetSupportedSoftwareKeyboardsForInputMode"), (void *)replace_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode, (void **)&original_UIKeyboardGetSupportedSoftwareKeyboardsForInputMode);
}