// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

import BraveVPN
import SnapKit
import UIKit

public class VPNLogsViewController: UIViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()

    let logsTextView = UITextView()
    logsTextView.isEditable = false

    view.addSubview(logsTextView)
    logsTextView.snp.makeConstraints { make in
      make.edges.equalTo(self.view)
    }

    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .long

    var logs = ""

    BraveVPN.errorLog.forEach {
      logs.append("\(formatter.string(from: $0.date)): \($0.message)\n")
    }

    logsTextView.text = logs
  }
}
