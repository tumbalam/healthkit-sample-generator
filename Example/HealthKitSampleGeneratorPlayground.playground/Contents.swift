//: Playground - noun: a place where people can play

import Foundation
import HealthKitSampleGenerator

var config = ExportConfiguration()

let documentsUrl = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]

config.outputFielName          = documentsUrl.URLByAppendingPathComponent("export.json").path!
config.exportType              = HealthDataToExportType.ALL
config.profileName             = "Profilename"
config.overwriteIfFileExist    = true

print(config.outputFielName)

config.outputStream = NSOutputStream.init(toFileAtPath: config.outputFielName!, append: false)!
config.outputStream!.open()

HealthKitDataExporter.INSTANCE.export(
    
    config,
    
    onProgress: {(message: String, progressInPercent: NSNumber?)->Void in
        // show progressinformation if you want
    },
    
    onCompletion: {(error: ErrorType?)-> Void in
        dispatch_async(dispatch_get_main_queue(), {
            if let exportError = error {
                print(exportError)
            }
        })
    }
)