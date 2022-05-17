//
//  CustomTableViewCell.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 08.05.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // MARK: - properties
    
    // MARK: - View elements
    var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 5.0
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 5.0
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    var priceStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .equalSpacing
        stack.spacing = 5.0
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    var logo: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var tickerOfStock: UILabel = {
        var name: UILabel = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 20, weight: .semibold)
        return name
    }()
    
    var nameOfCompany: UILabel = {
        var name: UILabel = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 12, weight: .medium)
        return name
    }()
    
    var priceOfStock: UILabel = {
        var price: UILabel = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    var priceChange: UILabel = {
        var price: UILabel = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameStack.addArrangedSubview(tickerOfStock)
        nameStack.addArrangedSubview(nameOfCompany)
        priceStack.addArrangedSubview(priceOfStock)
        priceStack.addArrangedSubview(priceChange)
        horizontalStack.addArrangedSubview(logo)
        horizontalStack.setCustomSpacing(10, after: horizontalStack.subviews[0])
        horizontalStack.addArrangedSubview(nameStack)
        horizontalStack.addArrangedSubview(priceStack)
        contentView.addSubview(horizontalStack)
        contentView.backgroundColor = .gray
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ,constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            contentView.heightAnchor.constraint(equalToConstant: 90),
            logo.heightAnchor.constraint(equalTo: horizontalStack.heightAnchor),
            logo.widthAnchor.constraint(equalTo: horizontalStack.heightAnchor),
            priceStack.trailingAnchor.constraint(equalTo: horizontalStack.trailingAnchor)
        ])
        contentView.layer.cornerRadius = 20;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}






/*
 list of companies
MMM
AOS
ABT
ABBV
ABMD
ACN
ATVI
ADM
ADBE
AAP
AMD
AES
AFL
A
APD
AKAM
ALB
ALK
ARE
ALGN
ALLE
LNT
ALL
GOOGL
GOOG
MO
AMZN
AMCR
AEE
AAL
AEP
AXP
AIG
AMT
AWK
AMP
ABC
AME
AMGN
APH
ADI
ANSS
ANTM
AON
APA
AAPL
AMAT
APTV
ANET
AJG
AIZ
T
ATO
ADSK
ADP
AZO
AVB
AVY
BKR
BLL
BAC
BBWI
BAX
BDX
BRK.B
BBY
BIO
TECH
BIIB
BLK
BK
BA
BKNG
BWA
BXP
BSX
BMY
AVGO
BR
BRO
BF.B
CHRW
CDNS
CZR
CPB
COF
CAH
KMX
CCL
CARR
CTLT
CAT
CBOE
CBRE
CDW
CE
CNC
CNP
CDAY
CERN
CF
CRL
SCHW
CHTR
CVX
CMG
CB
CHD
CI
CINF
CTAS
CSCO
C
CFG
CTXS
CLX
CME
CMS
KO
CTSH
CL
CMCSA
CMA
CAG
COP
ED
STZ
CPRT
GLW
CTVA
COST
CTRA
CCI
CSX
CMI
CVS
DHI
DHR
DRI
DVA
DE
DAL
XRAY
DVN
DXCM
FANG
DLR
DFS
DISCA
DISCK
DISH
DG
DLTR
D
DPZ
DOV
DOW
DTE
DUK
DRE
DD
DXC
EMN
ETN
EBAY
ECL
EIX
EW
EA
LLY
EMR
ENPH
ETR
EOG
EFX
EQIX
EQR
ESS
EL
ETSY
RE
EVRG
ES
EXC
EXPE
EXPD
EXR
XOM
FFIV
FB
FAST
FRT
FDX
FIS
FITB
FRC
FE
FISV
FLT
FMC
F
FTNT
FTV
FBHS
FOXA
FOX
BEN
FCX
GPS
GRMN
IT
GNRC
GD
GE
GIS
GM
GPC
GILD
GPN
GL
GS
HAL
HBI
HAS
HCA
PEAK
HSIC
HES
HPE
HLT
HOLX
HD
HON
HRL
HST
HWM
HPQ
HUM
HBAN
HII
IBM
IEX
IDXX
INFO
ITW
ILMN
INCY
IR
INTC
ICE
IFF
IP
IPG
INTU
ISRG
IVZ
IPGP
IQV
IRM
JBHT
JKHY
J
SJM
JNJ
JCI
JPM
JNPR
KSU
K
KEY
KEYS
KMB
KIM
KMI
KLAC
KHC
KR
LHX
LH
LRCX
LW
LVS
LEG
LDOS
LEN
LNC
LIN
LYV
LKQ
LMT
L
LOW
LUMN
LYB
MTB
MRO
MPC
MKTX
MAR
MMC
MLM
MAS
MA
MTCH
MKC
MCD
MCK
MDT
MRK
MET
MTD
MGM
MCHP
MU
MSFT
MAA
MRNA
MHK
TAP
MDLZ
MPWR
MNST
MCO
MS
MSI
MSCI
NDAQ
NTAP
NFLX
NWL
NEM
NWSA
NWS
NEE
NLSN
NKE
NI
NSC
NTRS
NOC
NLOK
NCLH
NRG
NUE
NVDA
NVR
NXPI
ORLY
OXY
ODFL
OMC
OKE
ORCL
OGN
OTIS
PCAR
PKG
PH
PAYX
PAYC
PYPL
PENN
PNR
PBCT
PEP
PKI
PFE
PM
PSX
PNW
PXD
PNC
POOL
PPG
PPL
PFG
PG
PGR
PLD
PRU
PTC
PEG
PSA
PHM
PVH
QRVO
QCOM
PWR
DGX
RL
RJF
RTX
O
REG
REGN
RF
RSG
RMD
RHI
ROK
ROL
ROP
ROST
RCL
SPGI
CRM
SBAC
SLB
STX
SEE
SRE
NOW
SHW
SPG
SWKS
SNA
SO
LUV
SWK
SBUX
STT
STE
SYK
SIVB
SYF
SNPS
SYY
TMUS
TROW
TTWO
TPR
TGT
TEL
TDY
TFX
TER
TSLA
TXN
TXT
COO
HIG
HSY
MOS
TRV
DIS
TMO
TJX
TSCO
TT
TDG
TRMB
TFC
TWTR
TYL
TSN
USB
UDR
ULTA
UAA
UA
UNP
UAL
UPS
URI
UNH
UHS
VLO
VTR
VRSN
VRSK
VZ
VRTX
VFC
VIAC
VTRS
V
VNO
VMC
WRB
GWW
WAB
WBA
WMT
WM
WAT
WEC
WFC
WELL
WST
WDC
WU
WRK
WY
WHR
WMB
WLTW
WYNN
XEL
XLNX
XYL
YUM
ZBRA
ZBH
ZION
ZTS
 */

