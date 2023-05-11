namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Apagando BD...") 
      spinner.auto_spin
    %x(rails db:drop) 
    spinner.success('(Concluído!)')


    spinner = TTY::Spinner.new("[:spinner] Criando DB...") 
    spinner.auto_spin
      %x(db:create) 
    spinner.success('(Concluído!)')


    spinner = TTY::Spinner.new("[:spinner] Migrando as tabelas...") 
    spinner.auto_spin
    %x(db:migrate) 
    spinner.success('(Concluído!)')

    spinner = TTY::Spinner.new("[:spinner] Populando DB...") 
    spinner.auto_spin
    %x(db:seed) 
    spinner.success('(Concluído!)')

    
    else
      puts "Voce não está em modo de desenvolvimento"
    end
  end
end
