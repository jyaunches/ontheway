#import <UIKit/UIKit.h>

@class GoogleDirectionsConnection;

@interface RouteInputViewController : UIViewController{
    GoogleDirectionsConnection  *googleDirectionsConnection;
}

@property (strong, nonatomic) IBOutlet UITextField *origin;
@property (strong, nonatomic) IBOutlet UITextField *destination;
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end
