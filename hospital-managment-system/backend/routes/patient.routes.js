const express = require('express');
const router = express.Router();
const PatientController = require('../controllers/PatientController');
const authMiddleware = require('../middleware/authMiddleware');
const roleMiddleware = require('../middleware/roleMiddleware');

// Protected routes - only admin and staff can access
router.get('/', 
    authMiddleware, 
    roleMiddleware('admin', 'doctor', 'nurse', 'staff'), 
    PatientController.getAllPatients
);

router.get('/:id', 
    authMiddleware, 
    roleMiddleware('admin', 'doctor', 'nurse', 'staff'), 
    PatientController.getPatientById
);

router.post('/', 
    authMiddleware, 
    roleMiddleware('admin', 'staff'), 
    PatientController.createPatient
);

router.put('/:id', 
    authMiddleware, 
    roleMiddleware('admin', 'staff'), 
    PatientController.updatePatient
);

module.exports = router;