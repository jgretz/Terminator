//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "Memory.h"
#import "KnownPeople.h"
#import "OpenCVFaceRecognition.h"
#import "Person.h"
#import "PersonImage.h"

@interface Memory()

@property (strong) KnownPeople* knownPeople;
@property (strong) OpenCVFaceRecognition* openCVFaceRecognition;

@end

@implementation Memory

-(void) startup {
    [self loadFromDisk];
    [self loadFromAzure];

    [self trainUntrainedImages];
    [self trainOpenCV];
}

-(void) shutdown {

}

#pragma mark - Load
-(void) loadFromDisk {
    [self.knownPeople loadAll];
}

-(void) loadFromAzure {

}

#pragma mark - Train
-(void) addPersonNamed: (NSString*) name withImages: (NSArray*) images {
    Person* person = [Person object];
    person.id = [self.openCVFaceRecognition creatNewPersonNamed: name];
    person.name = name;

    [self.knownPeople addPerson: person];

    [self addImages: images toPerson: person];
}

-(void) addImages: (NSArray*) images toPerson: (Person*) person {
    for (UIImage* image in images) {
        [self.openCVFaceRecognition learnFace: image forPerson: person];

        PersonImage* personImage = [PersonImage object];
        personImage.image = image;
        personImage.trained = YES;

        [person.images addObject: personImage];
    }

    [self.knownPeople save];
    [self trainOpenCV];
}

-(void) trainUntrainedImages {
    for (Person* person in [[KnownPeople object] allPeople]) {
        for (PersonImage* image in person.images) {
            if (!image.trained) {
                [self.openCVFaceRecognition learnFace: image.image forPerson: person];
                image.trained = YES;
            }
        }
    }

    [self.knownPeople save];
}

-(void) trainOpenCV {
    [self.openCVFaceRecognition train];
}

@end