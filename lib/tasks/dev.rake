namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
  show_spinner("Apagando BD..."){%x(rails db:drop)}
  show_spinner("Criando BD..."){%x(rails db:create) }
  show_spinner("Migrando BD..."){%x(rails db:migrate)}
  %x(rails dev:add_mining_types)
  %x(rails dev:add_coins)
    else
      puts "Voce não está em modo de desenvolvimento"
    end
  end


  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
  coins =[
      {description: "Bitcoin",
      acronym: "BTC",
      url_image:
      "https://static.vecteezy.com/system/resources/thumbnails/008/505/801/small_2x/bitcoin-logo-color-illustration-png.png",
      mining_type: MiningType.find_by(acronym: 'PoW')
      },
      {description: "Dash",
      acronym: "DASH",
      url_image:
      "data:image/png;base64,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",
      mining_type: MiningType.all.sample
      },
      {description: "Ethereum",
      acronym: "ETH",
      url_image:
      "https://w7.pngwing.com/pngs/268/1013/png-transparent-ethereum-eth-hd-logo-thumbnail.png",
      mining_type: MiningType.all.sample
      },
  ]
coins.each do |coin|
  Coin.find_or_create_by!(coin)
    end 
  end
end

desc "Cadastro dos tipos de mineração"
task add_mining_types: :environment do
  show_spinner("Cadastrando tipos de mineração...") do
  mining_types = [
  {description:"Proof of Work", acronym: "PoW"},
  {description:"Proof of Stake", acronym: "PoS"},
  {description:"Proof of Capacity", acronym: "PoC"}
  ]
  mining_types.each do |mining_type|
    MiningType.find_or_create_by!(mining_type)
    end 
  end
end

  private
  def show_spinner(msg_start, msg_end = "Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}") 
    spinner.auto_spin
    yield 
    spinner.success("(#{msg_end})")
  end
end
