//
//  Permutation.m
//  Permutation
//
//  Created by TONY TRAN on 2013-07-16.
//  Copyright (c) 2013 TONY TRAN. All rights reserved.
//

#import "Permutation.h"

@interface Permutation ()


NSMutableDictionary* findAllConcurrenceOfEachCharInString(NSString *stringA);
BOOL permutation(NSString *stringA, NSString *stringB);


BOOL permutationUsingSet(NSString *stringA, NSString *stringB);

@end

@implementation Permutation

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString    *stringA                =   @"ababa";
    NSString    *stringB                =   @"aabbda";

    
    BOOL        isSlowPermutation       =   permutation(stringA, stringB);
    NSLog(@"%@ and %@  %@",stringA, stringB,isSlowPermutation ? @"are permutation" : @"are not permutation");

    BOOL        isFastPermutation       =   permutation(stringA, stringB);
    NSLog(@"%@ and %@  %@",stringA, stringB,isFastPermutation ? @"are permutation" : @"are not permutation");

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Slow permutation
NSMutableDictionary* findAllConcurrenceOfEachCharInString(NSString *stringA) {
    NSMutableDictionary *dict       =   [[NSMutableDictionary alloc] init];
    
    for ( int i = 0; i < stringA.length; i++ ) {
        
        int counts                  =   1;
        BOOL isAlreadyIn            =   FALSE;
        NSString    *current        =   [NSString stringWithFormat:@"%c",[stringA characterAtIndex:i]];
        
        // Check if current already exists
        for ( int m = 0 ; m < i ; m++) {
            NSString    *previous   =    [NSString stringWithFormat:@"%c",[stringA characterAtIndex:m]];
            if ( ![current isEqualToString:previous] ) {
                isAlreadyIn         =   FALSE;
            }
            else {
                isAlreadyIn         =   TRUE;
                break;
            }
        }
        
        // Get next and do comparison.
        if ( !isAlreadyIn ) {
            for ( int j = i + 1; j < stringA.length; j++) {
                NSString    *next    =   [NSString stringWithFormat:@"%c",[stringA characterAtIndex:j]];
                
                if ( [current isEqualToString:next])
                    counts++;
            }
            // Create a dict with key = 'current' and value = 'count'
            [dict setObject:[NSString stringWithFormat:@"%d",counts] forKey:current];
        }
    }
    return dict;
}

BOOL permutation(NSString *stringA, NSString *stringB) {
    
    if ( stringA.length != stringB.length )
        return FALSE;
        
    NSMutableDictionary *dict		=   findAllConcurrenceOfEachCharInString(stringA);
    NSMutableDictionary *result       	=   [[NSMutableDictionary alloc] init];
    
    // Check if each key in dict is also presented in second string. If yes, subtract a counter of this key
    for ( id key in dict ) {
        int        count    =   [dict[key] integerValue];
        for ( int i = 0 ; i < stringB.length ; i++) {
            NSString  *current  =   [NSString stringWithFormat:@"%c",[stringB characterAtIndex:i]];
            
            if ( [(NSString*)key isEqualToString:current] )
                count--;
        }
        [result setObject:[NSString stringWithFormat:@"%d",count] forKey:key];
        
        
    }

    BOOL   isPermuation;
    // If all keys in result have value of 0 then it is permutaion.Otherwise, not.
    for ( id key in result ) {
        if ( [result[key] integerValue] == 0 )
            isPermuation   =   TRUE;
        else
            return FALSE;
        
    }

    return isPermuation;
}

#pragma mark - Fast permutation
BOOL permutationUsingSet(NSString *stringA, NSString *stringB) {
    NSCountedSet    *setA                =   [NSCountedSet setWithCapacity:256];
    NSCountedSet    *setB                =   [NSCountedSet setWithCapacity:256];
    
    // Add character to a particular set. If two character are the same, 
    // only one will be added in but count will be increased
    for ( int i = 0 ; i < stringA.length ; i ++ ) {
        [setA addObject:[NSString stringWithFormat:@"%c",[stringA characterAtIndex:i]]];
    }
    for ( int i = 0 ; i < stringB.length ; i ++ ) {
        [setB addObject:[NSString stringWithFormat:@"%c",[stringB characterAtIndex:i]]];
    }
    // Check if 2 sets is sharing same number of common items
    BOOL    permutation;
    for (NSString  *itemA in setA) {
        if ( [setB containsObject:itemA] && [setA countForObject:itemA] == [setB countForObject:itemA] )
            permutation     =   YES;
        else {
            permutation     =   NO;
            break;
        }
    }
    return permutation;
}
@end
