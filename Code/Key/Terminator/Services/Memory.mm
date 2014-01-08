//
// Created by Joshua Gretz on 1/3/14.
// Copyright (c) 2014 gretz. All rights reserved.



#import "Memory.h"
#import "KnownPeople.h"
#import "OpenCVFaceRecognition.h"
#import "Person.h"
#import "AzureInterface.h"

@interface Memory()

@property (strong) KnownPeople* knownPeople;

@property (strong) OpenCVFaceRecognition* openCVFaceRecognition;
@property (strong) AzureInterface* azureInterface;

@end

@implementation Memory

-(void) startup {
    [self loadFromDisk];
    [self loadFromAzure];

    [self trainOpenCV];
}

-(void) shutdown {

}

#pragma mark - Load
-(void) loadFromDisk {
    [self.knownPeople loadFromDisk];
}

-(void) loadFromAzure {
    [self.azureInterface downloadPeopleFromAzure: ^(NSArray* array) {
        [self performBlockInBackground: ^{
            NSArray* known = self.knownPeople.allPeople;

            BOOL changed = NO;
            for (Person* azurePerson in array) {
                Person* local = [known firstWhere: ^BOOL(Person* evaluatedObject) {return [evaluatedObject.azureId isEqual: azurePerson.azureId];}];
                if (!local) {
                    // train
                    azurePerson.id = [self.openCVFaceRecognition creatNewPersonNamed: azurePerson.name];

                    if (azurePerson.images) {
                        for (UIImage* image in azurePerson.images)
                            [self.openCVFaceRecognition learnFace: image forPerson: azurePerson];
                    }
                    else {
                        azurePerson.images = [NSMutableArray array];
                    }

                    // save
                    [self.knownPeople addPerson: azurePerson];

                    changed = YES;
                }
                else {
                    for (int i = local.images.count; i < azurePerson.images.count; i++) {
                        UIImage* image = azurePerson.images[i];

                        // train
                        [self.openCVFaceRecognition learnFace: image forPerson: local];

                        // update
                        [local.images addObject: image];

                        changed = YES;
                    }
                }
            }

            if (changed) {
                [self.knownPeople save];
                [self trainOpenCV];
            }
        }];
    }];
}

#pragma mark - Train
-(void) addPersonNamed: (NSString*) name withImages: (NSArray*) images {
    Person* person = [Person object];
    person.id = [self.openCVFaceRecognition creatNewPersonNamed: name];
    person.name = name;
    person.images = [NSMutableArray array];

    [self.knownPeople addPerson: person];

    [self addImages: images toPerson: person];
}

-(void) addImages: (NSArray*) images toPerson: (Person*) person {
    for (UIImage* image in images) {
        [self.openCVFaceRecognition learnFace: image forPerson: person];

        [person.images addObject: image];
    }

    [self.knownPeople save];
    [self trainOpenCV];

    [self.azureInterface writePersonToAzure: person];
}

-(void) trainOpenCV {
    @synchronized (self) {
        [self.openCVFaceRecognition train];
    }
}

@end