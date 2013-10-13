/*
 NSString+Inflections.m
 Inflections
 
 Copyright (c) 2010 Adam Elliot (adam@adamelliot.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "NSString+Inflections.h"

@implementation NSString (Inflections)


// All rules are assumed Global Case Insensitive.
+ (NSArray *)pluralRules {
	static NSArray *_pluralRules = nil;
    
	if (_pluralRules == nil)
		_pluralRules = [NSArray arrayWithObjects:
                         [NSArray arrayWithObjects:@"(matr|vert|ind)(?:ix|ex)$", @"$1ices", nil],
                         [NSArray arrayWithObjects:@"(m)an$", @"$1en", nil],
                         [NSArray arrayWithObjects:@"(pe)rson$", @"$1ople", nil],
                         [NSArray arrayWithObjects:@"(child)$", @"$1ren", nil],
                         [NSArray arrayWithObjects:@"^(ox)$", @"$1en", nil],
                         [NSArray arrayWithObjects:@"(ax|test)is$", @"$1es", nil],
                         [NSArray arrayWithObjects:@"(octop|vir)us$", @"$1i", nil],
                         [NSArray arrayWithObjects:@"(alias|status)$", @"$1es", nil],
                         [NSArray arrayWithObjects:@"(bu)s$", @"$1ses", nil],
                         [NSArray arrayWithObjects:@"(buffal|tomat|potat)o$", @"$1oes", nil],
                         [NSArray arrayWithObjects:@"([ti])um$", @"$1a", nil],
                         [NSArray arrayWithObjects:@"sis$", @"ses", nil],
                         [NSArray arrayWithObjects:@"(?:([^f])fe|([lr])f)$", @"$1$2ves", nil],
                         [NSArray arrayWithObjects:@"(hive)$", @"$1s", nil],
                         [NSArray arrayWithObjects:@"([^aeiouy]|qu)y$", @"$1ies", nil],
                         [NSArray arrayWithObjects:@"(x|ch|ss|sh)$", @"$1es", nil],
                         [NSArray arrayWithObjects:@"([m|l])ouse$", @"$1ice", nil],
                         [NSArray arrayWithObjects:@"(quiz)$", @"$1zes", nil],
                         [NSArray arrayWithObjects:@"(cow)$", @"kine", nil],
                         [NSArray arrayWithObjects:@"s$", @"s", nil],
                         [NSArray arrayWithObjects:@"$", @"s", nil],
                         nil];
    
	return _pluralRules;
}

+ (NSArray *)singularRules {
	static NSArray *_singularRules = nil;
    
	if (_singularRules == nil)
		_singularRules = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"(database)s$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(m)en$", @"$1an", nil],
                           [NSArray arrayWithObjects:@"(pe)ople$", @"$1rson", nil],
                           [NSArray arrayWithObjects:@"(child)ren$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(n)ews$", @"$1ews", nil],
                           [NSArray arrayWithObjects:@"([ti])a$", @"$1um", nil],
                           [NSArray arrayWithObjects:@"((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$", @"$1$2sis", nil],
                           [NSArray arrayWithObjects:@"(^analy)ses$", @"$1sis", nil],
                           [NSArray arrayWithObjects:@"([lr])ves$", @"$1f", nil],
                           [NSArray arrayWithObjects:@"([^f])ves$", @"$1fe", nil],
                           [NSArray arrayWithObjects:@"(hive)s$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(tive)s$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(curve)s$", @"$1", nil],
                           [NSArray arrayWithObjects:@"([^aeiouy]|qu)ies$", @"$1y", nil],
                           [NSArray arrayWithObjects:@"(s)eries$", @"$1eries", nil],
                           [NSArray arrayWithObjects:@"(m)ovies$", @"$1ovie", nil],
                           [NSArray arrayWithObjects:@"(x|ch|ss|sh)es$", @"$1", nil],
                           [NSArray arrayWithObjects:@"([m|l])ice$", @"$1ouse", nil],
                           [NSArray arrayWithObjects:@"(bus)es$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(o)es$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(shoe)s$", @"$1", nil],
                           [NSArray arrayWithObjects:@"(cris|ax|test)es$", @"$1is", nil],
                           [NSArray arrayWithObjects:@"(octop|vir)i$", @"$1us", nil],
                           [NSArray arrayWithObjects:@"(alias|status)es$", @"$1", nil],
                           [NSArray arrayWithObjects:@"^(ox)en", @"$1", nil],
                           [NSArray arrayWithObjects:@"(vert|ind)ices$", @"$1ex", nil],
                           [NSArray arrayWithObjects:@"(matr)ices$", @"$1ix", nil],
                           [NSArray arrayWithObjects:@"(quiz)zes$", @"$1", nil],
                           [NSArray arrayWithObjects:@"s$", @"", nil],
                           nil];
    
	return _singularRules;
}

+ (NSArray *)nonTitlecasedWords {
	static NSArray *_nonTitlecasedWords = nil;
    
	if (_nonTitlecasedWords == nil)
		_nonTitlecasedWords = [NSArray arrayWithObjects:
                                @"and",@"or",@"nor",@"a",@"an",@"the",@"so",@"but",@"to",@"of",@"at",
                                @"by",@"from",@"into",@"on",@"onto",@"off",@"out",@"in",@"over",
                                @"with",@"for",nil];
    
	return _nonTitlecasedWords;
}



/**
 * Converts an underscored separated string into a CamelCasedString.
 *
 * Changes '/' to '::' to convert paths to namespaces.
 */
- (NSString *)camelize {
	NSMutableString *ret = [NSMutableString string];
	NSString *str = [self lowercaseString];
	NSArray *strPath = [str componentsSeparatedByString:@"/"];
    
	for (int i = 0; i < [strPath count]; i++) {
		NSString *s1 = [strPath objectAtIndex:i];
		NSArray *strArr = [s1 componentsSeparatedByString:@"_"];
		for (int x = 0; x < [strArr count]; x++) {
			NSString *s2 = [strArr objectAtIndex:x];
			unichar l = [s2 characterAtIndex:0];
			NSString *letter = [[NSString stringWithCharacters:&l length:1] uppercaseString];
			NSString *rest = [s2 substringFromIndex:1];
			[ret appendFormat:@"%@%@", letter, rest];
		}
		if (i < [strPath count] - 1) [ret appendString:@"::"];
	}
    
	return ret;
}

/**
 * Converts an underscored separated string into a camelCasedString with the
 * first letter lower case.
 *
 * Changes '/' to '::' to convert paths to namespaces.
 */
- (NSString *)camelizeWithLowerFirstLetter {
	NSString *ret = [self camelize];
    
	unichar l = [ret characterAtIndex:0];
	NSString *letter = [[NSString stringWithCharacters:&l length:1] lowercaseString];
	NSString *rest = [ret substringFromIndex:1];
    
	return [NSString stringWithFormat:@"%@%@", letter, rest];
}


/**
 * Removes the module part from the expression in the string.
 */
- (NSString *)demodulize {
	NSArray *parts = [self componentsSeparatedByString:@"::"];
	return [parts lastObject];
}

/**
 * Creates a foreign key name from a class name.
 */
- (NSString *)foreignKey {
	return [[[self demodulize] underscore] stringByAppendingString:@"_id"];
}

/**
 * Creates a foreign key name from a class name without the underscore
 * separating the id part.
 */
- (NSString *)foreignKeyWithoutIdUnderscore {
	return [[[self demodulize] underscore] stringByAppendingString:@"id"];
}

/**
 * Turns a number into an ordinal string used to denote the position in an
 * ordered sequence such as 1st, 2nd, 3rd, 4th.
 *
 * TODO: This should be moved to NSNumber most likely
 */
- (NSString *)ordinalize {
	NSInteger i = [self integerValue];
	int mod100 = i % 100;
    
	if (mod100 >= 11 && mod100 <= 13)
		return [NSString stringWithFormat:@"%dth", i];
	else switch (i % 10) {
		case 1:		return [NSString stringWithFormat:@"%dst", i];
		case 2:		return [NSString stringWithFormat:@"%dnd", i];
		case 3:		return [NSString stringWithFormat:@"%drd", i];
		default: 	return [NSString stringWithFormat:@"%dth", i];
	}
    
	return @"";
}

/**
 * Capitalizes the first letter and makes everything else lower case.
 */
- (NSString *)capitalize {
	unichar l = [self characterAtIndex:0];
	NSString *letter = [[NSString stringWithCharacters:&l length:1] uppercaseString];
	NSString *rest = [[self substringFromIndex:1] lowercaseString];
    
	return [NSString stringWithFormat:@"%@%@", letter, rest];
}
@end