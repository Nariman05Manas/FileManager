//
//  ViewController.swift
//  FileManagerI_Ios-18
//
//  Created by qwerty on 14.07.2022.
//

import UIKit
class ViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var images = [MyImages]()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 105
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "documentCell")
        
        view.backgroundColor = .darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(tapAddButton))
        
        initialLayout()
        myLibrary()
    }
    
    @objc func tapAddButton() {
        
        let alert = UIAlertController(title: "IMAGE", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "PHOTOGALLERY", style: .default) { (alert) in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionPhoto)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func myLibrary() {
        self.images.removeAll()
        
        let manager = FileManager.default
        guard let docUrl = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false),
              let contents = try? FileManager.default.contentsOfDirectory(at: docUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
        else { return }
        
        
        for i in contents {
            let myPath = i.path
            do {
                try FileManager.default.attributesOfItem(atPath: myPath)
            } catch let error {
                print(error)
            }
            
            let image = UIImage(contentsOfFile: myPath)
            images.append(MyImages(image: image ?? UIImage(),
                                   path: myPath))
        }
    }
    
    func saveImage(image: UIImage) {
        let manager = FileManager.default
        guard let docUrl = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
        
        let imageName = UUID().uuidString
        let imagePath = docUrl.appendingPathComponent("\(imageName).jpg")
        let data = image.jpegData(compressionQuality: 1.0)
        manager.createFile(atPath: imagePath.path, contents: data)
        myLibrary()
        tableView.reloadData()
    }
    
    private func deleteImage(_ fileImage: String) {
        do {
            try FileManager.default.removeItem(atPath: fileImage)
        } catch {
            print(error)
        }
    }
    
    func initialLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.saveImage(image: pickedImage)
        dismiss(animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FILES"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteImage(images[indexPath.row].path)
            myLibrary()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.myCellConfig(images: images[indexPath.row])
        return cell
    }
    
}
