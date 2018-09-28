//
//  DocumentViewController.swift
//  MediaLibraryManager
//
//  Created by Vivian Breda Bezerra Rego on 9/26/18.
//  Copyright © 2018 Nikolah Pearce. All rights reserved.
//

import Cocoa

class DocumentViewController: NSViewController {
    
    var fileToOpen : MMFile = File(filename: "default")
    var fullpath : String = ""
    
    convenience init(file: MMFile) {
        self.init()
        fileToOpen = file
        fullpath = file.path+"/"+file.filename
    }

    @IBOutlet weak var documentView: NSScrollView!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var pdfView: NSImageView!
    @IBOutlet weak var failIndicator: NSProgressIndicator!
    @IBOutlet weak var failMessage: NSTextField!
    
    override func viewDidLoad() {
        failIndicator.isHidden = true
        failMessage.isHidden = true
        super.viewDidLoad()
        showText()
    }
    
    func showText() {
        
        let filepath : String = NSString(string: fullpath).expandingTildeInPath

        let separateExtension: [String] = fileToOpen.filename.split(separator: ".").map({String($0)})
        let ext : String = separateExtension[1]
        
        if(ext == "txt") {
        do {
            let contents = try String(contentsOfFile: filepath)
            textView.string = contents;
            textView.isEditable = false ;
        } catch {}
        } else if (ext == "pdf") {
            pdfView.image = NSImage(contentsOfFile: filepath)
        } else {
            failIndicator.isHidden = false
            failIndicator.startAnimation(self)
            failMessage.isHidden = false
        }
    }
    
}
