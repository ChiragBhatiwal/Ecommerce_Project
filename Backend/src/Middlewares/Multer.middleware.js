const multer = require('multer');
const cloudinary = require("../Utils/Cloudinary");
const {CloudinaryStorage} = require("multer-storage-cloudinary");

const storage = new CloudinaryStorage({
  cloudinary: cloudinary,
  params: {
    folder: 'uploads', // Folder name in Cloudinary
    allowedFormats: ['jpg', 'png', 'jpeg'],
  },
});

module.exports= upload = multer({storage})