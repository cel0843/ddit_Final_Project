package kr.or.ddit.fingerprint;

import java.io.InputStream;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.fazecast.jSerialComm.SerialPort;

import kr.or.ddit.mapper.IFingerprintMapper;
import kr.or.ddit.vo.FingerprintVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FingerprintServiceImpl implements IFingerprintService{
	
	@Inject
	private IFingerprintMapper mapper;
	
	SerialPort comPort;
	
	public void openPortSetting() {
		log.info("kr.or.ddit.fingerprint.FingerprintServiceImpl		openPortSetting() 실행...!");
		
		comPort = SerialPort.getCommPort("COM4"); // connect Arduino
		if (!comPort.isOpen()) {
			comPort.setComPortParameters(9600, 8, SerialPort.ONE_STOP_BIT, SerialPort.NO_PARITY); // port setting
			boolean portStatus = comPort.openPort(); // port open
			
			log.info("##### openPortSetting() >> portStatus : " + portStatus);
			
			if (portStatus) {
				log.info("##### openPortSetting() >> SerialPort OPEN success!!!");
			} else {
				log.info("##### openPortSetting() >> SerialPort OPEN failed!!!");
			}
		} else {
			log.info("##### openPortSetting() >> SerialPort already OPEN!!!");
		}
	}	
	
	@Override
	public String resetModule() {
		log.info("kr.or.ddit.fingerprint.FingerprintServiceImpl		resetModule() 실행...!");
		String status = "";
		
		if (comPort != null) {
			System.out.println("##### resetModule() >> comPort Info : " + comPort.toString());
		}
		
        if (comPort != null && comPort.isOpen()) { 
        	comPort.closePort(); 
            try {
            	// 리소스가 해제되도록 지연 시간 추가
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
    	}
        
        openPortSetting();
        
        status = comPort.isOpen() ? "success" : "error";
        
        System.out.println("##### resetModule() >> 초기화 상태 : " + status);
        return status;
	}
	
	@Override
	public List<FingerprintVO> getWorkList(boolean init) {
		log.info("kr.or.ddit.fingerprint.FingerprintServiceImpl		insertWorkBeginTime() 실행...!");
		
		if (init) { 
			openPortSetting(); 
		}
		return mapper.getWorkList();
	}

	@Override
	public int insertWorkBeginTime() {
		log.info("kr.or.ddit.fingerprint.FingerprintServiceImpl		insertWorkBeginTime() 실행...!");
		
		int resultCodeNo = 0;
		
		if (comPort.isOpen()) { // port open check
			InputStream in = comPort.getInputStream();
			final int scanTime = 20; // port open time
			int cnt = 0; // tried count
			
			loop:
			while(true) {
				if (cnt > scanTime) {
					break;
				}
				cnt++;
				
				byte[] buffer = new byte[1024];
				int len = -1;
				try {
					Thread.sleep(1000); // interval 1 second
					while ((len = in.read(buffer)) > -1) {
						String fid = new String(buffer, 0, len);
						fid = fid.trim();
						System.out.println("##### 스캔된 지문 정보 : " + fid); // del
						if (!(fid == null || fid.equals(""))) { // 지문 스캔 성공시
							String emplId = mapper.selectEmplIdbyFid(fid);
							System.out.println("##### 조회된 사원 ID : " + emplId); // del
							int resultCount = mapper.insertWorkBeginTime(emplId); // 출근 등록
							resultCodeNo = resultCount > 0 ? 1 : 2;
							break loop;
						} 
					}
				} catch (Exception e) {
					resultCodeNo = 4;
					log.info("##### 지문 인식 중...");
				}
			}
		}
		
		return resultCodeNo;
	}

}
