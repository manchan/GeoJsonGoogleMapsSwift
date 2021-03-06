/* Copyright (c) 2016 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "GMUFeature.h"
#import "GMUStyle.h"

@implementation GMUFeature

@synthesize geometry = _geometry;
@synthesize style = _style;

- (instancetype)initWithGeometry:(id<GMUGeometry>)geometry
                      identifier:(NSString * _Nullable)identifier
                      properties:(NSDictionary<NSString *, id> * _Nullable)properties
                     boundingBox:(GMSCoordinateBounds * _Nullable)boundingBox {
  if (self = [super init]) {
      _geometry = geometry;
      _identifier = identifier;
      _boundingBox = boundingBox;
      _properties = properties;
      _svg = _properties[@"svg"] ?: NULL;
      _southWest = properties[@"southWest"];
      _northEast = properties[@"northEast"];
      _bearing = [NSNumber numberWithDouble:[properties[@"bearing"] doubleValue]];
//      _style = [[GMUStyle alloc] initWithStyleID:@"1" strokeColor:UIColor.cyanColor fillColor:UIColor.cyanColor width:2.0 scale:10 heading:0 anchor:CGPointZero iconUrl:NULL title:@"hoge" hasFill:YES hasStroke:YES];
  }
  return self;
}

@end
