package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListAppAccessStatusDto;
import com.insure.rfq.dto.ClientLoginDto;
import com.insure.rfq.dto.GetAllAppAccessDto;
import com.insure.rfq.dto.UpdateAppAccessDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListAppAccess;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidDepartmentException;
import com.insure.rfq.exception.InvalidDesignationException;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.login.entity.Department;
import com.insure.rfq.login.entity.Designation;
import com.insure.rfq.login.repository.DepartmentRepository;
import com.insure.rfq.login.repository.DesignationRepository;
import com.insure.rfq.login.service.JwtService;
import com.insure.rfq.repository.ClientListAppAccessRepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListAppAccessService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
//@Slf4j
public class ClientListAppAccessServiceImpl implements ClientListAppAccessService {

    private ClientListRepository clientListRepository;

    private ProductRepository productRepository;

    private DepartmentRepository departmentRepository;

    private DesignationRepository designationRepository;

    private ClientListAppAccessRepository clientListAppAccessRepository;


    private JavaMailSender emailSender;


    private Random random = new Random();
    private JwtService jwtService;
    String active = "ACTIVE";

    public ClientListAppAccessServiceImpl(ClientListRepository clientListRepository, ProductRepository productRepository, DepartmentRepository departmentRepository, DesignationRepository designationRepository, ClientListAppAccessRepository clientListAppAccessRepository, JavaMailSender emailSender, JwtService jwtService) {
        this.clientListRepository = clientListRepository;
        this.productRepository = productRepository;
        this.departmentRepository = departmentRepository;
        this.designationRepository = designationRepository;
        this.clientListAppAccessRepository = clientListAppAccessRepository;
        this.emailSender = emailSender;

        this.jwtService = jwtService;
    }

    private Workbook getWorkbook(MultipartFile file) throws IOException {

        String fileName = file.getOriginalFilename();


        if (fileName != null && (fileName.endsWith(".xlsx") || fileName.endsWith(".XLSX") || fileName.endsWith(".xlsb")
                || fileName.endsWith(".XLSB"))) {
            // Handle XLSX
            return new XSSFWorkbook(file.getInputStream());
        } else if (fileName != null && (fileName.endsWith(".xls") || fileName.endsWith(".XLS"))) {
            // Handle XLS
            return new HSSFWorkbook(file.getInputStream());
        } else {
            // Throw an exception or handle the unsupported file format
            throw new IllegalArgumentException("Unsupported file format: " + fileName);
        }
    }

    private String getStringCellValue(Cell cell) {
        if (cell == null) {
            return null;
        }
        return cell.getStringCellValue();
    }

    @Override
    public String uploadAppAccessExcel(MultipartFile multipartFile, Long clientListId, Long productId)
            throws IOException {
        Workbook workbook = getWorkbook(multipartFile);
        List<ClientListAppAccess> clientListAppAccessDtos = new ArrayList<>();

        Sheet sheet = workbook.getSheetAt(0);
        for (Row row : sheet) {
            if (row.getRowNum() == 0) {
                // Skip header row
                continue;
            }

            ClientListAppAccess clientListAppAccess = new ClientListAppAccess(); // Create a new instance for each row

            if (clientListId != null) {
                try {
                    ClientList clientList = clientListRepository.findById(clientListId)
                            .orElseThrow(() -> new InvalidClientList("ClientList is not Found"));
                    clientListAppAccess.setClientList(clientList);
                    clientListAppAccess.setRfqId(clientList.getRfqId());
                } catch (InvalidClientList e) {
                    // Handle exception
                }
            }
            if (productId != null) {
                try {
                    Product product = productRepository.findById(productId)
                            .orElseThrow(() -> new InvalidProduct("Product is not Found"));
                    clientListAppAccess.setProduct(product);
                } catch (InvalidProduct e) {
                    // Handle exception
                }
            }
            clientListAppAccess.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));

            clientListAppAccess.setRecordStatus(active);
            clientListAppAccess.setAppAccessStatus(active);
            // Assuming the column order is: Emp ID, Emp Name, Relationship, Email, Phone
            clientListAppAccess.setEmployeeId(getStringCellValue(row.getCell(1))); // Emp ID
            clientListAppAccess.setEmployeeName(getStringCellValue(row.getCell(2)));
            clientListAppAccess.setDateOfBirth(getStringCellValue(row.getCell(3)));
            clientListAppAccess.setRelationship(getStringCellValue(row.getCell(6))); // Relationship
            clientListAppAccess.setAge(getStringCellValue(row.getCell(4)));
            clientListAppAccess.setGender(getStringCellValue(row.getCell(5)));
            clientListAppAccess.setSumInsured(getStringCellValue(row.getCell(7)));
            clientListAppAccess.setEmail(getStringCellValue(row.getCell(8))); // Email
            clientListAppAccess.setPhoneNumber(getStringCellValue(row.getCell(9))); // Phone

            clientListAppAccessDtos.add(clientListAppAccess);
        }

        List<ClientListAppAccess> clientListAppAccesses = clientListAppAccessRepository
                .saveAll(clientListAppAccessDtos);
        if (!clientListAppAccesses.isEmpty()) {
            return "Created Successfully";
        } else {
            return "Failed to create ";
        }
    }

    @Override
    public boolean sendLoginCredentials(List<String> employeeEmails) {

        List<String> passwords = generateRandomPasswords(employeeEmails.size());
        for (int i = 0; i < employeeEmails.size(); i++) {
            String email = employeeEmails.get(i);
            String password = passwords.get(i);
            if (!sendEmail(email, password)) {
                return false;
            }
            // Update password in the database
            updateUserPassword(email, password);
        }
        return true;
    }

    @Override
    public List<GetAllAppAccessDto> getAllAppAccessDto(Long clientListId, Long productId) {
        return clientListAppAccessRepository.findAll().stream()
                .filter(i -> i.getRecordStatus().equalsIgnoreCase(active))
                .filter(i -> clientListId != 0 && i.getClientList().getCid() == clientListId)
                .filter(i -> productId != 0 && i.getProduct().getProductId().equals(productId)).map(i -> {
                    GetAllAppAccessDto appAccessDto = new GetAllAppAccessDto();
                    appAccessDto.setAppAccessId(i.getAppAccessId());
                    appAccessDto.setEmployeeNo(i.getEmployeeId());
                    appAccessDto.setName(i.getEmployeeName());
                    appAccessDto.setRelationship(i.getRelationship());
                    appAccessDto.setAge(i.getAge());
                    appAccessDto.setRole(i.getRole());
                    appAccessDto.setDateOfBirth(i.getDateOfBirth());
                    appAccessDto.setEmail(i.getEmail());
                    appAccessDto.setPhoneNumber(i.getPhoneNumber());
                    appAccessDto.setGender(i.getGender());
                    appAccessDto.setSumInsured(i.getSumInsured());
                    if (i.getAppAccessStatus().equalsIgnoreCase(active)) {
                        appAccessDto.setAppAccessStatus("ACTIVATED");
                    } else {
                        appAccessDto.setAppAccessStatus("DEACTIVATED");
                    }
                    if (i.getDepartment() != null) {
                        appAccessDto.setDepartment(i.getDepartment().getDepartmentName());
                    } else {
                        appAccessDto.setDepartment(null);
                    }
                    if (i.getDesignation() != null) {
                        appAccessDto.setDesignation(i.getDesignation().getDesignationName());
                    } else {
                        appAccessDto.setDesignation(null);
                    }
                    return appAccessDto;
                }).toList();
    }

    @Override
    public GetAllAppAccessDto getAllAppAccessDtoById(Long appAccessId) {
        ClientListAppAccess appAccessDto = clientListAppAccessRepository.findById(appAccessId).orElse(null);
        if (appAccessDto != null) {
            GetAllAppAccessDto getAllAppAccessDto = new GetAllAppAccessDto();
            getAllAppAccessDto.setAppAccessId(appAccessDto.getAppAccessId());
            getAllAppAccessDto.setEmployeeNo(appAccessDto.getEmployeeId());
            getAllAppAccessDto.setName(appAccessDto.getEmployeeName());
            getAllAppAccessDto.setRelationship(appAccessDto.getRelationship());
            getAllAppAccessDto.setAge(appAccessDto.getAge());
            getAllAppAccessDto.setRole(appAccessDto.getRole());
            getAllAppAccessDto.setDateOfBirth(appAccessDto.getDateOfBirth());
            getAllAppAccessDto.setEmail(appAccessDto.getEmail());
            getAllAppAccessDto.setPhoneNumber(appAccessDto.getPhoneNumber());
            getAllAppAccessDto.setGender(appAccessDto.getGender());
            getAllAppAccessDto.setSumInsured(appAccessDto.getSumInsured());
            getAllAppAccessDto.setAppAccessStatus(appAccessDto.getAppAccessStatus());
            if (appAccessDto.getDepartment() != null) {
                getAllAppAccessDto.setDepartment(appAccessDto.getDepartment().getDepartmentName());
            } else {
                getAllAppAccessDto.setDepartment(null);
            }
            if (appAccessDto.getDesignation() != null) {
                getAllAppAccessDto.setDesignation(appAccessDto.getDesignation().getDesignationName());
            } else {
                getAllAppAccessDto.setDesignation(null);
            }

            return getAllAppAccessDto;
        } else {
            return null;
        }
    }

    @Override
public UpdateAppAccessDto updateAppAccessDtoById(Long appAccessId, UpdateAppAccessDto updateAppAccessDto) {
    ClientListAppAccess appAccessDto = clientListAppAccessRepository.findById(appAccessId)
           .orElseThrow(() -> new RuntimeException("ClientListAppAccess not found"));

    updateAppAccessDto.setEmployeeNo(appAccessDto.getEmployeeId());
    updateAppAccessDto.setName(appAccessDto.getEmployeeName());
    updateAppAccessDto.setRelationship(appAccessDto.getRelationship());
    updateAppAccessDto.setGender(appAccessDto.getGender());
    updateAppAccessDto.setDateOfBirth(appAccessDto.getDateOfBirth());
    updateAppAccessDto.setAge(appAccessDto.getAge());
    updateAppAccessDto.setSumInsured(appAccessDto.getSumInsured());
    updateAppAccessDto.setEmail(appAccessDto.getEmail());
    updateAppAccessDto.setPhoneNumber(appAccessDto.getPhoneNumber());
    updateAppAccessDto.setRole(appAccessDto.getRole());

    updateDepartmentAndDesignation(appAccessDto, updateAppAccessDto);

    ClientListAppAccess savedClientListAppAccess = clientListAppAccessRepository.save(appAccessDto);

    updateAppAccessDto.setDepartment(getDepartmentName(savedClientListAppAccess));
    updateAppAccessDto.setDesignation(getDesignationName(savedClientListAppAccess));

    return updateAppAccessDto;
}

private void updateDepartmentAndDesignation(ClientListAppAccess appAccessDto, UpdateAppAccessDto updateAppAccessDto) {
    if (updateAppAccessDto.getDepartment()!= null) {
        updateDepartment(appAccessDto, updateAppAccessDto);
    }

    if (updateAppAccessDto.getDesignation()!= null) {
        updateDesignation(appAccessDto, updateAppAccessDto);
    }
}

private void updateDepartment(ClientListAppAccess appAccessDto, UpdateAppAccessDto updateAppAccessDto) {
    try {
        Department department = departmentRepository
               .findById(Long.parseLong(updateAppAccessDto.getDepartment()))
               .orElseThrow(() -> new InvalidDepartmentException("Department is not Found"));
        appAccessDto.setDepartment(department);
    } catch (InvalidDepartmentException e) {
        throw new InvalidDepartmentException("Invalid department");
    }
}

private void updateDesignation(ClientListAppAccess appAccessDto, UpdateAppAccessDto updateAppAccessDto) {
    try {
        Designation designation = designationRepository
               .findById(Long.parseLong(updateAppAccessDto.getDesignation()))
               .orElseThrow(() -> new InvalidDesignationException("Designation is not Found"));
        appAccessDto.setDesignation(designation);
    } catch (InvalidDesignationException e) {
        throw new InvalidDesignationException("Invalid designation");
    }
}

private String getDepartmentName(ClientListAppAccess savedClientListAppAccess) {
    if (savedClientListAppAccess.getDepartment()!= null) {
        return savedClientListAppAccess.getDepartment().getDepartmentName();
    } else {
        return null;
    }
}

private String getDesignationName(ClientListAppAccess savedClientListAppAccess) {
    if (savedClientListAppAccess.getDesignation()!= null) {
        return savedClientListAppAccess.getDesignation().getDesignationName();
    } else {
        return null;
    }
}

    @Override
    public ClientLoginDto authenticate(String username, String password) {
        ClientListAppAccess clientListAppAccess = clientListAppAccessRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Invalid credentials"));

        if (!password.equals(clientListAppAccess.getPassword())) {
            throw new UsernameNotFoundException("Invalid credentials");
        }

        ClientLoginDto clientLoginDto = new ClientLoginDto();
        clientLoginDto.setAccessToken(jwtService.generateToken(username));
        clientLoginDto.setClientListId(clientListAppAccess.getClientList().getCid());
        clientLoginDto.setProductId(clientListAppAccess.getProduct().getProductId());
        clientLoginDto.setEmployeeId(clientListAppAccess.getEmployeeId());

        return clientLoginDto;
    }

    @Override
    public String changeAppAccessStatus(List<ClientListAppAccessStatusDto> clientListAppAccessStatusDto) {
        // Iterate over the DTOs
        for (ClientListAppAccessStatusDto dto : clientListAppAccessStatusDto) {
            Long appAccessId = dto.getAppAccessId();
            String status = dto.getStatus();

            // Retrieve the ClientListAppAccess entity by id
            ClientListAppAccess clientListAppAccess = clientListAppAccessRepository.findById(appAccessId).orElse(null);

            if (clientListAppAccess != null) {
                if ("ACTIVATE".equalsIgnoreCase(status)) {
                    clientListAppAccess.setAppAccessStatus("ACTIVATE");
                } else if ("DEACTIVATE".equalsIgnoreCase(status)) {
                    clientListAppAccess.setAppAccessStatus("DEACTIVATE");
                }
                clientListAppAccessRepository.save(clientListAppAccess);
            }
        }
        // Return some indication of success or failure
        return "App access status updated successfully";

    }

    @Override
public String deleteAppAccessById(Long appAccessId) {
    ClientListAppAccess clientListAppAccess = clientListAppAccessRepository.findById(appAccessId)
           .orElseThrow(() -> new RuntimeException("ClientListAppAccess not found"));

    if (clientListAppAccess!= null) {
        clientListAppAccess.setRecordStatus("INACTIVE");
        clientListAppAccessRepository.save(clientListAppAccess);
    }

    return "App access deleted successfully";
}

    private List<String> generateRandomPasswords(int count) {

        List<String> passwords = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            StringBuilder passwordBuilder = new StringBuilder();
            for (int j = 0; j < 8; j++) {
                char randomChar = (char) (random.nextInt(26) + 'a'); // Generate lowercase letters only
                passwordBuilder.append(randomChar);
            }
            passwords.add(passwordBuilder.toString());
        }
        return passwords;
    }

    private void updateUserPassword(String email, String password) {
    ClientListAppAccess clientListAppAccess = clientListAppAccessRepository.findByEmail(email)
           .orElseThrow(() -> new UsernameNotFoundException("User not found"));

    if (clientListAppAccess!= null) {
        clientListAppAccess.setPassword(password);
        clientListAppAccessRepository.save(clientListAppAccess);
    }
}

    private boolean sendEmail(String email, String password) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Your Login Credentials");
            message.setText("Hello User ,\n\n" + "Your login credentials are as follows:\n" + "Username: " + email
                    + "\n" + "Password: " + password + "\n\n"
                    + "Please use the following link to log in: http://14.99.138.131:9980/Securisk\n\n" + "Thank you,\n"
                    + "Securisk Insure Broker");

            emailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
