package com.insure.rfq.service.impl;

import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.insure.rfq.entity.ClientDetailsClaimsMis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.insure.rfq.dto.ClaimAnayalisMisReportDto;
import com.insure.rfq.dto.ClaimAnayalisReportDto;
import com.insure.rfq.payload.AgeWiseClaimAnalysis;
import com.insure.rfq.payload.ClaimTypeAnalysis;
import com.insure.rfq.payload.DiseaseWiseAnalysis;
import com.insure.rfq.payload.GenderWiseClaimReport;
import com.insure.rfq.payload.IncurredCliamRatio;
import com.insure.rfq.payload.MemberTypeAnalysis;
import com.insure.rfq.payload.RelationWiseClaimReport;
import com.insure.rfq.repository.ClientDetailsClaimsMisRepository;
import com.insure.rfq.service.ClientListClaimsMisAnalysisService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ClientListAnalysisClaimsMisImpl implements ClientListClaimsMisAnalysisService {

	public ClientListAnalysisClaimsMisImpl(ClientDetailsClaimsMisRepository clientDetailsClaimsMisRepository) {
		this.clientDetailsClaimsMisRepository = clientDetailsClaimsMisRepository;
	}

	private ClientDetailsClaimsMisRepository clientDetailsClaimsMisRepository;
	@Override
	public ClaimAnayalisMisReportDto generateReport(Long clientListId, Long productId) {






	        int amount=0;
	//
	        int amountrela=0;
	//
	        String child="";
	        ClaimAnayalisMisReportDto claimAnayalisReportDto=new ClaimAnayalisMisReportDto();

	        MemberTypeAnalysis analysis = new MemberTypeAnalysis();
	        // Get the current system date
	        LocalDate currentDate = LocalDate.now();
	        // Extract the month from the current date
	        Month desiredMonth = currentDate.getMonth();
	        clientDetailsClaimsMisRepository.findAll()
	                .stream()
	                .filter(i -> i.getRecordStatus().equalsIgnoreCase("ACTIVE"))
	                .filter(i -> isUserValid(clientListId, i))
	                .filter(i -> isProductValid(productId, i))
	                .filter(i -> {
	                    // Extract month from createdDate
	                    LocalDate createdDate = i.getCreatedDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	                    Month month = createdDate.getMonth();
	                    return month == desiredMonth;
	                })
	                .forEach(c -> {
	                    Set<String> relations = clientDetailsClaimsMisRepository.getAllRelationData(clientListId, productId);
						extractedMemberDetails(clientListId, productId, relations, analysis, claimAnayalisReportDto);
					});

	        Set<String> allGenderDetails = clientDetailsClaimsMisRepository.getAllGenderDetails(clientListId, productId);
	        allGenderDetails.remove(null);

	        List<GenderWiseClaimReport> getAllGenderWiseDetails = new ArrayList<>();
		extractedGenderWiseDetails(clientListId, productId, allGenderDetails, getAllGenderWiseDetails);

		// adding gender wise report
	        claimAnayalisReportDto.setGenderWiseClaimReport(getAllGenderWiseDetails);

	        // Relation Wise Claim Analysis
	        Set<String> relation = clientDetailsClaimsMisRepository.getAllRelationData(clientListId, productId);
	        relation.remove(null);
	        List<RelationWiseClaimReport> relationWiseReport = new ArrayList<>();
	        RelationWiseClaimReport relationWiseClaimReports = new RelationWiseClaimReport();

	        // __--count

	        for (String rela : relation) {
	            RelationWiseClaimReport relationWiseClaimReport = new RelationWiseClaimReport();
	            if(rela.equalsIgnoreCase("Mother")) {
	                relationWiseClaimReport.setRelation("Mother");
	                relationWiseClaimReport.setCount(clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId));
	                relationWiseClaimReport.setAmount(clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId));
	                relationWiseReport.add(relationWiseClaimReport);
	            }
	            else if(rela.equalsIgnoreCase("Father"))
	            {
	                relationWiseClaimReport.setRelation("Father");
	                relationWiseClaimReport.setCount(clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId));
	                relationWiseClaimReport.setAmount(clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId));
	                relationWiseReport.add(relationWiseClaimReport);
	            }
	            else {
					String spouse = "Spouse";
					String husband = "Husband";
					if (isInGivenFamily(rela, husband, spouse))
					{
						relationWiseClaimReport.setRelation(husband);
						relationWiseClaimReport.setCount(clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId));
						relationWiseClaimReport.setAmount(clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId));
						relationWiseReport.add(relationWiseClaimReport);
					}
					else if (isInGivenFamily(rela, "wife", spouse))
					{
						relationWiseClaimReport.setRelation(spouse);
						relationWiseClaimReport.setCount(clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId));
						relationWiseClaimReport.setAmount(clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId));
						relationWiseReport.add(relationWiseClaimReport);
					}
	
	
	//
		//
	//
					else if(isInGivenFamily(rela, "Employee", "Self"))
					{
						relationWiseClaimReport.setRelation("Self");
						relationWiseClaimReport.setCount(clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId));
						relationWiseClaimReport.setAmount(clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId));
						relationWiseReport.add(relationWiseClaimReport);
					}
					else {

						child="child";
						amount=amount+clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId);

						amountrela=amountrela+clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId);

	
					}
				}


	        }

	        if(child.equals("child"))
	        {
	            relationWiseClaimReports.setRelation("Child");
	            relationWiseClaimReports.setCount(amount);
	            relationWiseClaimReports.setAmount(amountrela);
	            relationWiseReport.add(relationWiseClaimReports);

	        }


	        claimAnayalisReportDto.setRelationWiseClaimReport(relationWiseReport);


	        AgeWiseClaimAnalysis ageWiseClaimAnalysis = new AgeWiseClaimAnalysis();

		extractedAfterValidatingAge(clientListId, productId, ageWiseClaimAnalysis, claimAnayalisReportDto);

	        Set<String> allClaimType = clientDetailsClaimsMisRepository.getAllClaimType(clientListId, productId);
	        allClaimType.remove(null);
	        allClaimType.remove("");
	        List<ClaimTypeAnalysis> getlaimDetails = new ArrayList<>();

	        for (String claimType : allClaimType) {
				ClaimTypeAnalysis analysis1 = getClaimTypeAnalysis(clientListId, productId, claimType);
				getlaimDetails.add(analysis1);
	        }

	        claimAnayalisReportDto.setClaimTypeAnalysis(getlaimDetails);
	        Set<String>allStatus;
	        allStatus= clientDetailsClaimsMisRepository.getAllStatus(clientListId, productId);
	        allStatus.remove(null);
	        allStatus.remove("");
	        if(allStatus.size()==0)
	        {

	            allStatus.remove(null);
	            allStatus.remove("");

	        }
	        List<IncurredCliamRatio> incurred = new ArrayList<>();

		extractedInCurredClaimsRatio(clientListId, productId, allStatus, incurred);

		claimAnayalisReportDto.setIncurredCliamRatio(incurred);

	        Set<String> diseaseList = clientDetailsClaimsMisRepository.getAllDisease(clientListId, productId);
	        diseaseList.remove(null);
	        List<DiseaseWiseAnalysis> getAllDiswaseWiseAnalysis = new ArrayList<>();

	        for (String disease : diseaseList) {
	            DiseaseWiseAnalysis diseaseWiseAnalysis = new DiseaseWiseAnalysis();
	            diseaseWiseAnalysis.setDiseaseName(disease);
	            diseaseWiseAnalysis.setDiseaseCount(clientDetailsClaimsMisRepository.getCountBasedOnDisease(disease, clientListId, productId));
	            diseaseWiseAnalysis.setAmount(clientDetailsClaimsMisRepository.getAmountBasedOnDisease(disease, clientListId, productId));
	            getAllDiswaseWiseAnalysis.add(diseaseWiseAnalysis);
	        }
	        claimAnayalisReportDto.setDiseaseWiseAnalysis(getAllDiswaseWiseAnalysis);
	        return claimAnayalisReportDto;
	    }

	private void extractedInCurredClaimsRatio(Long clientListId, Long productId, Set<String> allStatus, List<IncurredCliamRatio> incurred) {
		for (String status : allStatus) {
			IncurredCliamRatio incurredCliamRatio = new IncurredCliamRatio();
			incurredCliamRatio.setStatus(status);
			incurredCliamRatio.setCount(clientDetailsClaimsMisRepository.getCountBasedOnStatus(status, clientListId, productId));
			incurredCliamRatio.setAmount(clientDetailsClaimsMisRepository.getAmountBasedOnStatus(status, clientListId, productId));
			incurred.add(incurredCliamRatio);
		}
	}

	private void extractedGenderWiseDetails(Long clientListId, Long productId, Set<String> allGenderDetails, List<GenderWiseClaimReport> getAllGenderWiseDetails) {
		for (String allgender : allGenderDetails) {

			GenderWiseClaimReport claimReport = new GenderWiseClaimReport();
			if(isInGivenFamily(allgender, "Male", "M")) {
				claimReport.setGender("Male");
				claimReport.setGenderCount(clientDetailsClaimsMisRepository.getCountOfGenderWise(allgender, clientListId, productId));
				double totalNumber = getPercentageCountdata(allgender,  clientDetailsClaimsMisRepository.getCountOfGenderWise(allgender, clientListId, productId), clientListId, productId);
				claimReport.setCountPerct(totalNumber);
				claimReport.setAmount(clientDetailsClaimsMisRepository.getGenderWiseAmountSum(allgender, clientListId, productId));
				double totalAmount = getPercentageAmountData(clientListId, productId, clientDetailsClaimsMisRepository.getGenderWiseAmountSum(allgender, clientListId, productId));
				claimReport.setAmountPerct(totalAmount);
				getAllGenderWiseDetails.add(claimReport);
			}
			else if(isInGivenFamily(allgender, "Female", "F"))
			{
				claimReport.setGender("Female");
				claimReport.setGenderCount(clientDetailsClaimsMisRepository.getCountOfGenderWise(allgender, clientListId, productId));
				double totalNumber = getPercentageCountdata(allgender,  clientDetailsClaimsMisRepository.getCountOfGenderWise(allgender, clientListId, productId), clientListId, productId);
				claimReport.setCountPerct(totalNumber);
				claimReport.setAmount(clientDetailsClaimsMisRepository.getGenderWiseAmountSum(allgender, clientListId, productId));
				double totalAmount = getPercentageAmountData(clientListId, productId, clientDetailsClaimsMisRepository.getGenderWiseAmountSum(allgender, clientListId, productId));
				claimReport.setAmountPerct(totalAmount);
				getAllGenderWiseDetails.add(claimReport);
			}
		}
	}

	private void extractedMemberDetails(Long clientListId, Long productId, Set<String> relations, MemberTypeAnalysis analysis, ClaimAnayalisMisReportDto claimAnayalisReportDto) {
		for (String rela : relations) {
			if (isInGivenFamily(rela, "Self", "Employee")) {
				analysis.setMainMemberCount(clientDetailsClaimsMisRepository.getCountOfMemeberBasedOnRelation(rela, clientListId, productId));
				analysis.setDependentCount(clientDetailsClaimsMisRepository.getCountOfMemeberTypeIsNotSelf(rela, clientListId, productId));
				analysis.setMainMemberCountAmount(clientDetailsClaimsMisRepository.getAmountOfMember(rela, clientListId, productId));
				analysis.setDependentCountDepedentAmount(clientDetailsClaimsMisRepository.getAmountDepent(rela, clientListId, productId));
				claimAnayalisReportDto.setMemberTypeAnalysis(analysis);
			}
		}
	}

	private ClaimTypeAnalysis getClaimTypeAnalysis(Long clientListId, Long productId, String claimType) {
		ClaimTypeAnalysis analysis1 = new ClaimTypeAnalysis();
		analysis1.setStatus(claimType);
		analysis1.setNumber(clientDetailsClaimsMisRepository.getCountBasedOnClaimType(claimType, clientListId, productId));
		analysis1.setAmount(clientDetailsClaimsMisRepository.getAmountBasedOnClaimType(claimType, clientListId, productId));
		return analysis1;
	}

	private void extractedAfterValidatingAge(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis, ClaimAnayalisMisReportDto claimAnayalisReportDto) {
		extractedAgeFrom0To10(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeFrom11To20(clientListId, productId, ageWiseClaimAnalysis);


		extractedAgeFrom21To30(clientListId, productId, ageWiseClaimAnalysis);

		extractedAgeFrom31To40(clientListId, productId, ageWiseClaimAnalysis);

		extractedAgeFrom41To50(clientListId, productId, ageWiseClaimAnalysis);

		extractedAgeFrom51To60(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeFrom61To70(clientListId, productId, ageWiseClaimAnalysis);

		extractedAgeMoreThan70(clientListId, productId, ageWiseClaimAnalysis);

		// amount

		extractedAgeCountFrom0TO10(clientListId, productId, ageWiseClaimAnalysis);

		extractedAgeCountFrom11To20(clientListId, productId, ageWiseClaimAnalysis);

		extractedAgeCountFrom21To30(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeCountFrom31To40(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeCountFrom41To50(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeCountFrom51To60(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeCountFrom61To70(clientListId, productId, ageWiseClaimAnalysis);
		extractedAgeCountMoreThan70(clientListId, productId, ageWiseClaimAnalysis);

		claimAnayalisReportDto.setAgeWiseClaimAnalysis(ageWiseClaimAnalysis);
	}

	private void extractedAgeCountMoreThan70(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedAgeMoreThan70(clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount70AndAboveAmount(clientDetailsClaimsMisRepository.getAmountOfMemberAgeMoreThan70(clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount70AndAboveAmount(0);
		}
	}

	private void extractedAgeCountFrom61To70(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(61, 70, clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount0To10Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(61, 70, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount61To70Amount(0);
		}
	}

	private void extractedAgeCountFrom51To60(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(51, 60, clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount0To10Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(51, 60, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount51To60Amount(0);
		}
	}

	private void extractedAgeCountFrom41To50(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(41, 50, clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount41To50Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(41, 50, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount41To50Amount(0);

		}
	}

	private void extractedAgeCountFrom31To40(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(31, 40, clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount31To40Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(31, 40, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount31To40Amount(0);
		}
	}

	private void extractedAgeCountFrom21To30(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(21, 30, clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount21To30Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(21, 30, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount21To30Amount(0);
		}
	}

	private void extractedAgeCountFrom11To20(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(11, 20, clientListId, productId) > 0) {
			ageWiseClaimAnalysis
					.setAgeCount11To20Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(11, 20, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount11To20Amount(0);
		}
	}

	private void extractedAgeCountFrom0TO10(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(0, 10, clientListId, productId) > 0) {

			ageWiseClaimAnalysis
					.setAgeCount0To10Amount(clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(0, 10, clientListId, productId));
			log.info("{}", clientDetailsClaimsMisRepository.getAmountOfMemberBasedOnAge(0, 10, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount0To10Amount(0.0);
		}
	}

	private void extractedAgeMoreThan70(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedAgeMoreThan70(clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount61To70(clientDetailsClaimsMisRepository.getCountOfMemberBasedAgeMoreThan70(clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount70AndAbove(0);
		}
	}

	private void extractedAgeFrom61To70(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(61, 70, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount61To70(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(61, 70, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount61To70(0);
		}
	}

	private void extractedAgeFrom51To60(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(51, 60, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount51To60(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(51, 60, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount51To60(0);
		}
	}

	private void extractedAgeFrom41To50(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(41, 50, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount41To50(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(41, 50, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount41To50(0);
		}
	}

	private void extractedAgeFrom31To40(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(31, 40, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount31To40(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(31, 40, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount31To40(0);
		}
	}

	private void extractedAgeFrom21To30(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(21, 30, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount21To30(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(21, 30, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount21To30(0);
		}
	}

	private void extractedAgeFrom11To20(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(11, 20, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount11To20(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(11, 20, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount11To20(0);
		}
	}

	private void extractedAgeFrom0To10(Long clientListId, Long productId, AgeWiseClaimAnalysis ageWiseClaimAnalysis) {
		if (clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(0, 10, clientListId, productId) > 0) {
			ageWiseClaimAnalysis.setAgeCount0To10(clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(0, 10, clientListId, productId));
			log.info("{}", clientDetailsClaimsMisRepository.getCountOfMemberBasedOnAge(0, 10, clientListId, productId));
		} else {
			ageWiseClaimAnalysis.setAgeCount0To10(0);

		}
	}

	private static boolean isInGivenFamily(String rela, String husband, String spouse) {
		return rela.equalsIgnoreCase(husband) || rela.equalsIgnoreCase(spouse);
	}

	private static boolean isProductValid(Long productId, ClientDetailsClaimsMis i) {
		return productId != 0 && i.getProduct() != null
				&& i.getProduct().getProductId().equals(productId);
	}

	private static boolean isUserValid(Long clientListId, ClientDetailsClaimsMis i) {
		return clientListId != 0 && i.getClientList() != null
				&& i.getClientList().getCid() == clientListId;
	}

	public double getPercentageCountdata(String allGender,int count,Long clientListId, Long productId)
	    {

	        int totalCount =clientDetailsClaimsMisRepository.getAllGenderCount(clientListId, productId);


	        return (double) (count * 100) /totalCount;
	    }

	    public double getPercentageAmountData(Long clientListId, Long productId,double amount)
	    {
	        int totalAmount = clientDetailsClaimsMisRepository.getAllGenderSum(clientListId, productId);
	        return (amount * 100)/totalAmount;
	    }

	}
	