//
//  MessageViewController.swift
//  Student Voice
//
//  Created by 4d on 3/22/23.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {

    let currentUser = Sender(senderId: "self", displayName: "iOS Academy")
    let otherUser = Sender(senderId: "other", displayName: "John Smith")
    lazy var currentSender: SenderType = currentUser

    var messages = [MessageType]()
    func loadFirstMessages() {
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: false)
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
loadFirstMessages()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messages.append(Message(sender: currentUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello World")))
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-76400), kind: .text("Hello to i")))
        messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-66400), kind: .text("How it going")))
        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-56400), kind: .text("im good")))
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-46400), kind: .text("nice")))
        messages.append(Message(sender: otherUser, messageId: "6", sentDate: Date().addingTimeInterval(-26400), kind: .text("ok")))

        print(messages.count)
print(messages)
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
       
        return messages[indexPath.section]
        
    }
    
 
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        print(messages.count)
        return messages.count

    }

}
