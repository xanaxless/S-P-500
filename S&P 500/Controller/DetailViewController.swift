//
//  DetailViewController.swift
//  S&P 500
//
//  Created by Yerkebulan Serikov on 25.05.2022.
//

import UIKit
import CorePlot

class DetailViewController: UIViewController {
    let rates: [Double] = [12,8,5,6,6,9,2]
    var stock: Stock!
    var plot1: CPTBarPlot!
    
    var hostView: CPTGraphHostingView = {
        return CPTGraphHostingView()
    }()
    /// MARK: - constant
    let BarWidth = 0.25
    let BarInitialX = 0.25
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hostView.frame = view.frame
        self.view.addSubview(hostView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func setupView(){
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "suit.heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonTapped(_:)))
        navigationItem.rightBarButtonItem = favoriteButton
        title = stock.companyName
        view.backgroundColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        
        let standartApperance = UINavigationBarAppearance()
        standartApperance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = standartApperance
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton!){
        
    }
}

extension DetailViewController: CPTBarPlotDataSource, CPTBarPlotDelegate {
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(rates.count)
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        if fieldEnum == UInt(CPTBarPlotField.barTip.rawValue) {
            return rates[Int(idx)]
        }
        return idx
    }
    
    func barPlot(_ plot: CPTBarPlot, barWasSelectedAtRecord idx: UInt, with event: UIEvent) {
        
    }
    
    func highestRateValue() -> Double {
        var maxRate = Double.leastNormalMagnitude
      for rate in rates {
        maxRate = max(maxRate, rate)
      }
      return maxRate
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initPlot()
    }
    
    func initPlot() {
        configureHostView()
        configureGraph()
        configureChart()
        configureAxes()
    }
    
    func configureHostView() {
        hostView.allowPinchScaling = false
    }
    
    func configureGraph() {
        // 1 - Create the graph
        let graph = CPTXYGraph(frame: hostView.bounds)
        graph.plotAreaFrame?.masksToBorder = false
        hostView.hostedGraph = graph
        // 2 - Configure the graph
        graph.apply(CPTTheme(named: CPTThemeName.plainWhiteTheme))
        graph.fill = CPTFill(color: CPTColor.clear())
        graph.paddingBottom = 60
        graph.paddingLeft = 60.0
        graph.paddingTop = 100
        graph.paddingRight = 30
        // 3 - Set up styles
        let titleStyle = CPTMutableTextStyle()
        titleStyle.color = CPTColor.black()
        titleStyle.fontName = "HelveticaNeue-Bold"
        titleStyle.fontSize = 16.0
        titleStyle.textAlignment = .center
        graph.titleTextStyle = titleStyle
        
        let title = "fdsafdsa"
        //"\(base.name) exchange rates\n\(rates.first!.date) - \(rates.last!.date)"
        graph.title = title
        graph.titlePlotAreaFrameAnchor = .top
        graph.titleDisplacement = CGPoint(x: 0.0, y: -16.0)
        
        // 4 - Set up plot space
        let xMin = 0.0
        let xMax = Double(rates.count)
        let yMin = 0.0
        let yMax = 1.4 * highestRateValue()
        guard let plotSpace = graph.defaultPlotSpace as? CPTXYPlotSpace else { return }
        plotSpace.xRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(xMin), lengthDecimal: CPTDecimalFromDouble(xMax - xMin))
        plotSpace.yRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(yMin), lengthDecimal: CPTDecimalFromDouble(yMax - yMin))
    }
    
    func configureChart() {
        // 1 - Set up the three plots
        plot1 = CPTBarPlot()
        plot1.fill = CPTFill(color: CPTColor(componentRed:0.92, green:0.28, blue:0.25, alpha:1.00))
       
        // 2 - Set up line style
        let barLineStyle = CPTMutableLineStyle()
        barLineStyle.lineColor = CPTColor.lightGray()
        barLineStyle.lineWidth = 0.5

        // 3 - Add plots to graph
        guard let graph = hostView.hostedGraph else { return }
        var barX = BarInitialX
        let plots = [plot1!]
        for plot: CPTBarPlot in plots {
          plot.dataSource = self
          plot.delegate = self
          plot.barWidth = NSNumber(value: BarWidth)
          plot.barOffset = NSNumber(value: barX)
          plot.lineStyle = barLineStyle
          graph.add(plot, to: graph.defaultPlotSpace)
          barX += BarWidth
        }
    }
    
    func configureAxes() {
    }
}
