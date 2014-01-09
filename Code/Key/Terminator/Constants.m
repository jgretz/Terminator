//
// Created by Joshua Gretz on 1/2/14.
// Copyright (c) 2014 gretz. All rights reserved.



@implementation Constants

-(NSString*) imageAddedToCameraRoll {return @"ImageAddedToCameraRoll";}
-(NSString*) facesFoundInImage {return @"FacesFoundInImage";}
-(NSString*) namelessPersonFound {return @"NamelessPersonFound";}
-(NSString*) terminatorMessage {return @"TerminatorMessage";}

-(NSString*) image {return @"Image";}
-(NSString*) timestamp {return @"Timestamp";}

+(Constants*) singleton {
    static Constants* singletonInstance;

    @synchronized (self) {
        if (!singletonInstance)
            singletonInstance = [[Constants alloc] init];

        return singletonInstance;
    }
}

+(NSString*) ImageAddedToCameraRoll {
    return Constants.singleton.imageAddedToCameraRoll;
}

+(NSString*) FacesFoundInImage {
    return Constants.singleton.facesFoundInImage;
}

+(NSString*) NamelessPersonFound {
    return Constants.singleton.namelessPersonFound;
}

+(NSString*) TerminatorMessage {
    return Constants.singleton.terminatorMessage;
}

+(NSString*) Image {
    return Constants.singleton.image;
}

+(NSString*) Timestamp {
    return Constants.singleton.timestamp;
}


@end