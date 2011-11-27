/***
 *    QuietSight Helpers
 *    @author - Skylar Schipper
 *	   @copyright - 2011 (c) Skylar Schipper
 *			(All rights reserved)
 *
 *    HEXParser.m
 *    11/27/2011
 *
 /////////////////////////////////////////////////////////
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of Skylar Schipper nor the names of any contributors may 
 be used to endorse or promote products derived from this software without 
 specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL SKYLAR SCHIPPER BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 /////////////////////////////////////////////////////////
 *
 *
 *
 *
 *
 *
 ***/

#import "HEXParser.h"

@implementation HEXParser

+(NSString*)normalizeHexString:(NSString *)hexString{
    // Declare Normalised string as empty
    NSString* nomHex;
    
    // If the input string doesn't have a leading # add it
    if (![hexString hasPrefix:@"#"]) {
        nomHex = [NSString stringWithFormat:@"#%@",hexString];
    } else {
        nomHex = hexString;
    }
    // Validate Characters as valid HexValues
    NSMutableString* str = [[NSMutableString alloc]init];
    [str appendFormat:@"#"];
    for (int i = 1; i<hexString.length; i++) {
        NSRange r = NSMakeRange(i, 1);
        NSString* c = [nomHex substringWithRange:r];
        validChar v = isValidHEXChar(c, i);
        if (v.isValid) {
            [str appendFormat:@"%@",[nomHex substringWithRange:NSMakeRange(v.atIndex, 1)]];
        }
    }
    // set nomHex to the validated string
    nomHex = str;
    // Truncate to 7 characters # and 6 values
    if ([nomHex length]>=8) {
        NSRange stringRange = {0, 7};
        stringRange = [nomHex rangeOfComposedCharacterSequencesForRange:stringRange];
        nomHex = [nomHex substringWithRange:stringRange];
    }
    // Check if the lenght is 4.  If it is change the 3 vals to 3 doubble vals ( #ad3 becomes #aadd33 )
    if ([nomHex length]==4) {
        NSString* first = [NSString stringWithFormat:@"%@%@",[nomHex substringWithRange:NSMakeRange(1, 1)],[nomHex substringWithRange:NSMakeRange(1, 1)]];
        NSString* second = [NSString stringWithFormat:@"%@%@",[nomHex substringWithRange:NSMakeRange(2, 1)],[nomHex substringWithRange:NSMakeRange(2, 1)]];
        NSString* third = [NSString stringWithFormat:@"%@%@",[nomHex substringWithRange:NSMakeRange(3, 1)],[nomHex substringWithRange:NSMakeRange(3, 1)]];
        nomHex = [NSString stringWithFormat:@"#%@%@%@",first,second,third];
    }
    // if the string is still to short add 0s to the end
    if ([nomHex length]<7) {
        NSMutableString* l = [nomHex mutableCopy];
        NSUInteger left = 7-[nomHex length];
        for (int i = 0; i<left; i++) {
            [l appendFormat:@"0"];
        }
        nomHex = l;
    }
    // Uppercase and return
    return [nomHex uppercaseString];
}


@end
