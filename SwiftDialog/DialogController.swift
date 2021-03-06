// Copyright 2014 Thomas K. Dyas
//   
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//   
// http://www.apache.org/licenses/LICENSE-2.0
//   
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import UIKit

public class DialogController : NSObject, UITableViewDataSource, UITableViewDelegate {
    public let root: RootElement
    public weak var viewController: DialogViewController?
    
    public init(_ rootElement: RootElement) {
        self.root = rootElement
    }
    
    func elementAtIndexPath(indexPath: NSIndexPath!) -> Element! {
        return self.root.sections[indexPath.section].elements[indexPath.row]
    }
    
    
    // UITableViewDataSource
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.root.sections.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let element = elementAtIndexPath(indexPath)
        return element.getCell(tableView)
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        let section = self.root.sections[sectionIndex]
        return section.elements.count
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        let section = self.root.sections[sectionIndex]
        return section.header
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection sectionIndex: Int) -> String? {
        let section = self.root.sections[sectionIndex]
        return section.footer
    }
    
    
    // UITableViewDelegate
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let element = self.elementAtIndexPath(indexPath)
        element.elementSelected(self, tableView: tableView, atPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let element = self.elementAtIndexPath(indexPath)
        element.elementDeselected(self, tableView: tableView, atPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let element = self.elementAtIndexPath(indexPath)
        element.accessoryButtonTapped(self, tableView: tableView, atPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
        let section = self.root.sections[sectionIndex]
        return section.headerView
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection sectionIndex: Int) -> UIView? {
        let section = self.root.sections[sectionIndex]
        return section.footerView
    }
}
